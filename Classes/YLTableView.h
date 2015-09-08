//
//  YLTableView.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLRefreshHeaderView;

typedef NS_ENUM(NSInteger, YLTableViewState) {
  //! Initial loading state. Pull to refresh header will not show.
  YLTableViewStateLoading = 0,
  //! Normal state. Nothing is currently loading.
  YLTableViewStateLoaded,
  //! Refreshing after a pull-to-refresh. The refreshHeaderView will be showing.
  YLTableViewStateRefreshing,
  //! Error state, eg network request errored.
  YLTableViewStateErrored,
};

@interface YLTableView : UITableView

//! If you want to use a refresh header, set this to a subclass of YLRefreshHeaderView
@property (strong, nonatomic, nullable) YLRefreshHeaderView *refreshHeaderView;

//! The current state of the table view. Will update the state of the refresh header as needed.
@property (assign, nonatomic) YLTableViewState state;

@end