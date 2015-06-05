//
//  YLTableViewCell.m
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLTableViewCell.h"
#import "YLTableViewCellPrivate.h"

const CGFloat kUITableViewCellDefaultHeight = 44.0;

@implementation YLTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    // this prevents the temporary unsatisfiable constraint state that the cell's contentView could
    // enter since it starts off 44pts tall
    self.contentView.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
  }
  return self;
}

#pragma mark Applying a cell's model

- (void)setModel:(NSObject *)model { }

#pragma mark Determining height of cells that use Auto Layout

- (CGFloat)heightForWidth:(CGFloat)width separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
  // set cell width
  CGRect bounds = self.bounds;
  bounds.size.width = width;
  self.bounds = bounds;

  // now force layout on cell view hierarchy using specified width
  // this makes sure any preferredMaxLayoutWidths, etc. are set
  [self layoutIfNeeded];

  // height computed based upon Auto Layout constraints in contentView
  const CGFloat contentViewHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

  if (contentViewHeight == 0) {
    // didn't seem like there were Auto Layout constraints that defined contentView's height
    return UITableViewAutomaticDimension;
  } else {
    // +0.5 or 1.0 to account for cell separator http://tomabuct.com/post/73484699239/uitableviews-in-ios-7
    const CGFloat kCellSeparatorViewHeight = (1 / UIScreen.mainScreen.scale);
    const CGFloat separatorHeight = separatorStyle == UITableViewCellSeparatorStyleNone ? 0 : kCellSeparatorViewHeight;

    return contentViewHeight + separatorHeight;
  }
}

@end
