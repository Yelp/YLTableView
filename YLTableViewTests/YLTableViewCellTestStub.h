//
//  YLTableViewCellTestStub.h
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//
#import <CoreGraphics/CGBase.h>
#import <UIKit/UITableViewCell.h>

#import <YLTableView/YLTableViewCell.h>

/**
 The height returned by calling estimatedRowHeight on this cell
 */
extern const CGFloat kYLTableViewCellStubHeight;

/**
 YLTableViewCell stub used for testing purposes
 */
@interface YLTableViewCellTestStub : UITableViewCell <YLTableViewCell>

@end
