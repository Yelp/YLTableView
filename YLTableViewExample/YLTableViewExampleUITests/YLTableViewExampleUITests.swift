//
//  YLTableViewExampleUITests.swift
//  YLTableViewExampleUITests
//
//  Created by Blake Tsuzaki on 9/9/16.
//  Copyright © 2016 Yelp. All rights reserved.
//

import XCTest

class YLTableViewExampleUITests: XCTestCase {
    
    private var tableView: XCUIElement {
        return XCUIApplication().tables.element(boundBy: 0)
    }
    private var refreshHeaderElement: XCUIElement {
        return tableView.otherElements["Refresh Header"]
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRefreshHeaderPullToRefreshCycle() {
        testRefreshHeaderStateNormal()
        tableViewPullToRefresh(tableView: tableView)
        testRefreshHeaderStateNormal()
    }
    
    func testRefreshHeaderStateNormal() {
        let evaluationPredicate = NSPredicate(format: "label == \"Pull to refresh...\"")
        
        XCTAssert(refreshHeaderElement.exists)
        
        expectation(for: evaluationPredicate, evaluatedWith: refreshHeaderElement, handler: nil)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRefreshHeaderStateReadyToRefresh() {
        let evaluationPredicate = NSPredicate(format: "label == \"Release to refresh\"")
        
        expectation(for: evaluationPredicate, evaluatedWith: refreshHeaderElement, handler: nil)
        tableViewPullToRefresh(tableView: tableView)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRefreshHeaderStateRefreshing() {
        let evaluationPredicate = NSPredicate(format: "label == \"Refreshing...\"")
        
        expectation(for: evaluationPredicate, evaluatedWith: refreshHeaderElement, handler: nil)
        tableViewPullToRefresh(tableView: tableView)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func tableViewPullToRefresh(tableView: XCUIElement) {
        let startPosition = tableView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let endPosition = tableView.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 1))
        startPosition.press(forDuration: 0, thenDragTo: endPosition)
    }
}
