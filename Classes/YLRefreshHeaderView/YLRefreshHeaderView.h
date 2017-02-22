//
//  YLRefreshHeaderView.h
//  YLTableView
//
//  Created by Mason Glidden on 7/31/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Enum to represent the current state of the YLRefreshHeaderView
 */
typedef NS_ENUM(NSInteger, YLRefreshHeaderViewState) {
  /**
   No refresh is currently happening. The user might have pulled the header down a bit, but not enough to trigger a refresh.
   */
  YLRefreshHeaderViewStateNormal = 0,
  /**
   The user has pulled down the header far enough to trigger a refresh, but has not released yet.
   */
  YLRefreshHeaderViewStateReadyToRefresh,
  /**
   Refreshing, either after the user pulled to refresh or a refresh was started programmatically.
   */
  YLRefreshHeaderViewStateRefreshing,
  /**
   The refresh has just finished and the refresh header is in the process of closing.
   */
  YLRefreshHeaderViewStateClosing,
};

/**
 Abstract class used for refresh header views. You'll need to implement the abstract methods below. YLTableView will call those methods automatically. Add a target for the UIControlEventValueChanged event to refresh the table view.
 */
@interface YLRefreshHeaderView : UIControl

/**
 The current state of the refresh header. The header should update its view as needed for the different states. If you override this method, you must call super.
 */
@property (assign, nonatomic) YLRefreshHeaderViewState refreshState;

/**
 Start / stop the refreshing animation in the given scroll view.
 */
- (void)setRefreshState:(YLRefreshHeaderViewState)refreshState animated:(BOOL)animated NS_REQUIRES_SUPER;

/**
 The current distance that the refresh header is being pulled. Will be updated as the user pulls the page down. Animations should be updated as this number changes.
 */
@property (assign, nonatomic) CGFloat currentPullAmount;

/**
 The distance the user will have to pull the header to trigger a refresh. Abstract method.
 */
@property (readonly, assign, nonatomic) CGFloat pullAmountToRefresh;

@end
