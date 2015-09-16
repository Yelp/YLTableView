//
//  YLTableViewCell.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kUITableViewCellDefaultHeight;

@interface YLTableViewCell : UITableViewCell

//! Apply a cell model to a cell.  Subclasses should implement this to decide how they display a model's content.
- (void)setModel:(nullable id)model;

/*! Set by YLTableView to indicate that this cell will be used solely for sizing and will never be displayed on screen.
 *
 *  For example, subclasses can use this information to optimize away unnecessary configuration.
 */
@property (readonly, assign, nonatomic, getter=isSizingCell) BOOL sizingCell;

@end