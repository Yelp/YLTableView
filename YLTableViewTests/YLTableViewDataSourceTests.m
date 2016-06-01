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

static NSString *const kCustomReuseIdentifier = @"NotAClass-ReuseId";

@interface YLTableViewDataSourceTests : XCTestCase

@property (strong, nonatomic) YLTableView *tableView;
@property (strong, nonatomic) YLTableViewDataSourceTestStub *dataSource;

@end

@implementation YLTableViewDataSourceTests

#pragma mark - Setup/Teardown

- (void)setUp {
  [super setUp];
  
  _tableView = [[YLTableView alloc] init];
  [_tableView registerClass:[YLTableViewCellTestStub class]
     forCellReuseIdentifier:NSStringFromClass([YLTableViewCellTestStub class])];
  [_tableView registerClass:[YLTableViewCellTestStub class]
     forCellReuseIdentifier:kCustomReuseIdentifier];

  _dataSource = [[YLTableViewDataSourceTestStub alloc] init];
  _dataSource.reuseIdentifiers = [self _reuseIdentifiersForTableView];

  _tableView.dataSource = _dataSource;
  _tableView.delegate = _dataSource;
}

#pragma mark - Helpers

- (NSDictionary<NSIndexPath *, NSString *> *)_reuseIdentifiersForTableView {
  return @{
    [self _indexPathForClassNameReuseIdentifier]: NSStringFromClass([YLTableViewCellTestStub class]),
    [self _indexPathForCustomReuseIdentifier]: kCustomReuseIdentifier,
  };
}

- (NSIndexPath *)_indexPathForClassNameReuseIdentifier {
  return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (NSIndexPath *)_indexPathForCustomReuseIdentifier {
  return [NSIndexPath indexPathForRow:1 inSection:0];
}

#pragma mark - Tests

- (void)testEstimatedRowHeightForClassNameReuseIdentifier {
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:[self _indexPathForClassNameReuseIdentifier]];
  XCTAssertEqual(height, kYLTableViewCellStubHeight);
}

- (void)testEstimatedRowHeightForCustomReuseIdentifier {
  CGFloat height = [self.dataSource tableView:self.tableView estimatedHeightForRowAtIndexPath:[self _indexPathForCustomReuseIdentifier]];
  XCTAssertEqual(height, kYLTableViewCellStubHeight);
}

- (void)testNonConformingCell {
  XCTAssertThrows([self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"]);
}

@end
