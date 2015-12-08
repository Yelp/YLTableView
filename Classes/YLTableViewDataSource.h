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

//! If the cells implement the YLTableViewCellEstimatedRowHeight protocol, that height will be used. Otherwise, the tableView can use an alternate height specified in this method.
- (CGFloat)estimatedHeightForRow;

//! Set as the parent view controller of any cells implementing YLTableViewChildViewControllerCell.
@property (weak, nonatomic, nullable) UIViewController *parentViewController;

//! Defaults to NO. If you would like to cache the estimated heights for rows, set this to YES.
@property (assign, nonatomic) BOOL shouldCacheEstimatedHeights;

@end
NS_ASSUME_NONNULL_END
