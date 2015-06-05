//
//  ViewController.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleViewController.h"

#import "YLExampleImagesCell.h"
#import "YLExampleImagesCellModel.h"
#import "YLExampleImagesViewController.h"
#import "YLExampleTableViewDataSource.h"
#import "YLExampleTextCell.h"
#import "YLExampleRefreshHeader.h"

#import <YLTableView/YLTableView.h>
#import <YLTableView/YLTableViewSectionHeaderFooterLabelView.h>

@interface YLExampleViewController () <YLExampleTableViewDataSourceDelegate>
@property (strong, nonatomic) YLTableView *tableView;
@property (strong, nonatomic) YLExampleTableViewDataSource *dataSource;
@end

@implementation YLExampleViewController

- (instancetype)init {
  if (self = [super init]) {
    // If using a pull to refresh header, you can't have extended layout on the top edge
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _dataSource = [[YLExampleTableViewDataSource alloc] init];
    _dataSource.parentViewController = self;
    _dataSource.delegate = self;
  }
  return self;
}

- (void)dealloc {
  _tableView.delegate = nil;
  _tableView.dataSource = nil;
}

- (void)loadView {
  [super loadView];
  self.view = self.tableView;
}

- (YLTableView *)tableView {
  if (!_tableView) {
    _tableView = [[YLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    // YLTableViewDataSource has to be the delegate and the dataSource of the table view.
    _tableView.dataSource = _dataSource;
    _tableView.delegate = _dataSource;

    // Make sure you set estimated row height, or UITableViewAutomaticDimension won't work.
    _tableView.estimatedRowHeight = 44.0;

    // Set up a refresh header
    _tableView.refreshHeaderView = [[YLExampleRefreshHeader alloc] init];
    [_tableView.refreshHeaderView addTarget:self action:@selector(_shouldRefresh) forControlEvents:UIControlEventValueChanged];

    // Registering cells and reuse identifiers
    [_tableView registerClass:[YLExampleTextCell class] forCellReuseIdentifier:NSStringFromClass([YLExampleTextCell class])];
    [_tableView registerClass:[YLExampleImagesCell class] forCellReuseIdentifier:NSStringFromClass([YLExampleImagesCell class])];
    [_tableView registerClass:[YLTableViewSectionHeaderFooterLabelView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YLTableViewSectionHeaderFooterLabelView class])];
  }
  return _tableView;
}

#pragma mark UIControlEvents

- (void)_shouldRefresh {
  self.tableView.state = YLTableViewStateRefreshing;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.tableView.state = YLTableViewStateLoaded;
  });
}

#pragma mark YLExampleTableViewDataSourceDelegate

- (void)exampleTableViewDataSource:(YLExampleTableViewDataSource *)dataSource didSelectImagesModel:(YLExampleImagesCellModel *)imagesModel {
  // This is the same view controller as used in YLExampleImagesCell, just presented normall on the stack.
  YLExampleImagesViewController *viewController = [[YLExampleImagesViewController alloc] init];
  viewController.imageOne = imagesModel.imageOne;
  viewController.imageTwo = imagesModel.imageTwo;
  viewController.imageThree = imagesModel.imageThree;
  [self.navigationController pushViewController:viewController animated:YES];
}

@end
