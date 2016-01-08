//
//  YLTableViewDataSourceTests.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableView.h"
#import "YLTableViewCell.h"
#import "YLTableViewCellTestStub.h"
#import "YLTableViewDataSource.h"
#import "YLTableViewDataSourceTestStub.h"

#import <XCTest/XCTestCase.h>

@interface YLTableViewDataSourceTests : XCTestCase

@property (strong, nonatomic) YLTableView *tableView;
@property (strong, nonatomic) YLTableViewDataSourceTestStub *dataSource;

@end

@implementation YLTableViewDataSourceTests

static const int kSectionIndexTableView = 0;
static const int kRowIndexTableViewConformingCell = 0;
static const int kRowIndexTableViewNonConformingCell = 1;

#pragma mark - Setup/Teardown

- (void)setUp {
  [super setUp];
  
  _tableView = [[YLTableView alloc] init];
  _dataSource = [[YLTableViewDataSourceTestStub alloc] init];
  _tableView.dataSource = _dataSource;
  _tableView.delegate = _dataSource;
  
  _dataSource.tableViewCells = [self _cellsForTableView];
}

#pragma mark - Helpers

- (NSDictionary<NSIndexPath *, UITableViewCell<YLTableViewCell> * > *)_cellsForTableView {
  return @{
    [self _indexPathForConformingCell]: [[YLTableViewCellTestStub alloc] init],
    [self _indexPathForNonConformingCell]: [[UITableViewCell alloc] init],
  };
}

- (NSIndexPath *)_indexPathForConformingCell {
  return [NSIndexPath indexPathForRow:kRowIndexTableViewConformingCell inSection:kSectionIndexTableView];
}

- (NSIndexPath *)_indexPathForNonConformingCell {
  return [NSIndexPath indexPathForRow:kRowIndexTableViewNonConformingCell inSection:kSectionIndexTableView];
}

#pragma mark - Tests

- (void)testEstimatedRowHeightFromConformingCell{
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:[self _indexPathForConformingCell]];
  XCTAssertEqual(height, kYLTableViewCellStubHeight);
}

- (void)testThatEstimatedRowHeightCannotBeCalledFromNonConformingCell {
  XCTAssertThrows([self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:[self _indexPathForNonConformingCell]]);
}


@end
