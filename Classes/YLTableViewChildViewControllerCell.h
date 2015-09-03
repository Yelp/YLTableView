//
//  YLTableViewChildViewControllerCell.h
//  YLTableView
//
//  Created by Mason Glidden on 3/30/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN
//! Implement this protocol in a YLTableViewCell subclass to use a child view controller inside of a table view cell. The YLTableViewDataSource subclass must have something set as the parentViewController property.
@protocol YLTableViewChildViewControllerCell <NSObject>

//! This method should return the view controller managed by the cell so that it can be properly connected with its parent.
@property (readonly, nonatomic) UIViewController *childViewController;

@end
NS_ASSUME_NONNULL_END
