//
//  YLTableViewSectionHeaderFooterViewPrivate.h
//  YLTableView
//
//  Created by Mason Glidden on 6/3/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

// NOTE: This header is not actually private. See PR#41: https://github.com/Yelp/YLTableView/pull/41

#import "YLTableViewSectionHeaderFooterView.h"

@interface YLTableViewSectionHeaderFooterView ()

/**
 Position of this header/footer in the table view
 */
@property (assign, nonatomic) YLTableViewSectionHeaderFooterPosition position;

/**
 * Returns contentView's computed height based upon Auto Layout constraints if non-0. Otherwise, it
 * returns UITableViewAutomaticDimension (which, when returned from UITableViewDelegate's
 * heightForRowAtIndexPath:, will size the header/footer defaultEmptySectionHeaderFooterHeight tall)
 *
 * @param width Width of the contentView to assume when determining height
 *
 * @result Height of header/footer calculated assuming its contentView is of the specified width
 */
- (CGFloat)heightForWidth:(CGFloat)width;

/**
 If YES, this instance is being used as a sizing header/footer and won't actually be displayed on screen.
 */
@property (assign, nonatomic, getter=isSizingView) BOOL sizingView;

@end
