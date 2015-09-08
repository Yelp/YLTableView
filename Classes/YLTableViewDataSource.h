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
- (void)reloadVisibleCellForModel:(NSObject *)model inTableView:(UITableView *)tableView;

//! Set as the parent view controller of any cells implementing YLTableViewChildViewControllerCell.
@property (weak, nonatomic, nullable) UIViewController *parentViewController;

@end
NS_ASSUME_NONNULL_END
