//
//  YLTableViewCell.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Defines required methods that a UITableViewCell subclass must implement to work with a YLTableViewDataSource
 */
@protocol YLTableViewCell <NSObject>

/**
 Apply a cell model to a cell.  Subclasses should implement this to decide how they display a model's content.
 */
- (void)setModel:(nullable id)model;

/**
 Estimated height for a cell, called within tableView:estimatedHeightForRowAtIndexPath
 */
+ (CGFloat)estimatedRowHeight;

@optional

/**
 Estimated height for a cell with the given model.

 This method is optional, but if implemented it will be called instead of estimatedRowHeight within
 tableView:estimatedHeightForRowAtIndexPath:
 */
+ (CGFloat)estimatedRowHeightForModel:(id)model;

@end

NS_ASSUME_NONNULL_END
