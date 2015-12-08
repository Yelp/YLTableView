//
//  YLTableViewDataSource.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLRefreshHeaderView;

NS_ASSUME_NONNULL_BEGIN
@interface YLTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

//! If one of model's properties has changed (but it's still the same object), this will reload the visible cell for that model. Useful whenever something mutates the state of a model (i.e. image loading)
- (void)reloadVisibleCellForModel:(id)model inTableView:(UITableView *)tableView;

/*!
 tableView:estimatedHeightForRowAtIndexPath can get the estimated height through the following ways:
 - For cells that conform to the YLTableViewCellEstimatedRowHeight protocol, the estimated height is specified via estimatedRowHeight
 - For cells that don't conform to this protocol, the estimated height can be specified by overriding this method: estimatedHeightForRow:inTableView
 - Otherwise, the iOS default of UITableViewAutomaticDimension will be used as the estimated height
 */
- (CGFloat)estimatedHeightForRow:(NSIndexPath *)row inTableView:(UITableView *)tableView;

//! Set as the parent view controller of any cells implementing YLTableViewChildViewControllerCell.
@property (weak, nonatomic, nullable) UIViewController *parentViewController;

//! Defaults to NO. If you would like to cache the estimated heights for rows, set this to YES.
@property (assign, nonatomic) BOOL shouldCacheEstimatedHeights;

@end
NS_ASSUME_NONNULL_END
