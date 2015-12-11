//
//  YLTableViewDataSourceTests.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableView.h"
#import "YLTableViewBaseTestCase.h"
#import "YLTableViewCell.h"
#import "YLTableViewCellEstimatedRowHeight.h"
#import "YLTableViewCellTestStub.h"
#import "YLTableViewDataSource.h"
#import "YLTableViewDataSourceTestStub.h"

@interface YLTableViewDataSourceTests : YLTableViewBaseTestCase

@property (strong, nonatomic) YLTableView *tableView;
@property (strong, nonatomic) YLTableViewDataSourceTestStub *dataSource;

@property (strong, nonatomic) NSIndexPath *indexPathOfConformingCell;
@property (strong, nonatomic) NSIndexPath *indexPathOfNonConformingCell;

@end

@implementation YLTableViewDataSourceTests

#pragma mark - Setup/Teardown

-(void)setUp {
  [super setUp];

  _indexPathOfConformingCell = [NSIndexPath indexPathForRow:0 inSection:0];
  _indexPathOfNonConformingCell = [NSIndexPath indexPathForRow:1 inSection:0];
  
  _tableView = [[YLTableView alloc] init];
  _dataSource = [[YLTableViewDataSourceTestStub alloc] init];
  _tableView.dataSource = _dataSource;
  _tableView.delegate = _dataSource;
  
  _dataSource.tableViewCells = [self _cellsForTableView];
}

-(void)tearDown {
  _tableView.delegate = nil;
  _tableView.dataSource = nil;
  [super tearDown];
}

#pragma mark - Helpers

-(NSDictionary *)_cellsForTableView {
  NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
  
  YLTableViewCell * nonConformingCell = [[YLTableViewCell alloc] init];
  YLTableViewCell * conformingCell = [[YLTableViewCellTestStub alloc] init];

  [dict setObject:nonConformingCell forKey:self.indexPathOfNonConformingCell];
  [dict setObject:conformingCell forKey:self.indexPathOfConformingCell];
  
  return (NSDictionary *)dict;
}

#pragma mark - Tests

-(void)_testEstimatedRowHeightWithConformingCell {
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:self.indexPathOfConformingCell];
  XCTAssertEqual(height, kYLTableViewCellStubHeight);
}

-(void)testThatEstimatedRowHeightIsFromCellConformingProtocol {
  self.dataSource.shouldProvideOverriddenHeight = NO;
  [self _testEstimatedRowHeightWithConformingCell];
}

-(void)testThatEstimatedRowHeightIsFromCellConformingProtocolEvenWithAlternateMethod {
  self.dataSource.shouldProvideOverriddenHeight = YES;
  [self _testEstimatedRowHeightWithConformingCell];
}

-(void)testThatEstimatedRowHeightIsFromAlternateMethodForNonConformingCell {
  self.dataSource.shouldProvideOverriddenHeight = YES;
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:self.indexPathOfNonConformingCell];
  XCTAssertEqual(height, kYLTableViewDataSourceTestStubOverridenHeight);
}

-(void)testThatEstimatedRowHeightIsDefault {
  self.dataSource.shouldProvideOverriddenHeight = NO;
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:self.indexPathOfNonConformingCell];
  XCTAssertEqual(height, UITableViewAutomaticDimension);
}

@end
