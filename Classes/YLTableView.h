//
//  YLTableView.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLTableViewCell;
@class YLTableViewSectionHeaderFooterView;
@class YLRefreshHeaderView;

typedef NS_ENUM(NSInteger, YLTableViewState) {
  YLTableViewStateLoading = 0, // Initial loading state. Pull to refresh header will not show.
  YLTableViewStateLoaded, // Normal state. Nothing is currently loading.
  YLTableViewStateRefreshing, // Refreshing after a pull-to-refresh. The refreshHeaderView will be showing.
  YLTableViewStateErrored, // Network request errored.
};

@interface YLTableView : UITableView

//! If you want to use a refresh header, set this to a subclass of YLRefreshHeaderView
@property (strong, nonatomic) YLRefreshHeaderView *refreshHeaderView;

//! The current state of the table view. Will update the state of the refresh header as needed.
@property (assign, nonatomic) YLTableViewState state;

@end