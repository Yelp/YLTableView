//
//  YLRefreshHeaderView.h
//  YLTableView
//
//  Created by Mason Glidden on 7/31/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YLRefreshHeaderViewState) {
  //! No refresh is currently happening. The user might have pulled the header down a bit, but not enough to trigger a refresh.
  YLRefreshHeaderViewStateNormal = 0,
  //! The user has pulled down the header far enough to trigger a refresh, but has not released yet.
  YLRefreshHeaderViewStateReadyToRefresh,
  //! Refreshing, either after the user pulled to refresh or a refresh was started programmatically.
  YLRefreshHeaderViewStateRefreshing,
  //! The refresh has just finished and the refresh header is in the process of closing.
  YLRefreshHeaderViewStateClosing,
};

//! Abstract class used for refresh header views. See YLRefreshHeaderViewSubclass for the abstract methods you'll need to implement. YLTableView will call those methods automatically. Add a target for the UIControlEventValueChanged event to refresh the table view.
@interface YLRefreshHeaderView : UIControl

@end
