//
//  YLTableViewSectionHeaderFooterView.h
//  YLTableView
//
//  Created by Tom Abraham on 11/11/13.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Enum to represent a header/footer view's position relative to sections in the table view
 */
typedef NS_ENUM(NSInteger, YLTableViewSectionHeaderFooterPosition) {
  /**
   Set when the position had not yet been defined
   */
  YLTableViewSectionHeaderFooterPositionUndefined,
  /**
   Any header but the first one in the table view
   */
  YLTableViewSectionHeaderFooterPositionHeader,
  /**
   The first header in the table view
   */
  YLTableViewSectionHeaderFooterPositionFirstHeader,
  /**
   Any footer but the last on one in the table view
   */
  YLTableViewSectionHeaderFooterPositionFooter,
  /**
   The last footer in the table view
   */
  YLTableViewSectionHeaderFooterPositionLastFooter,
};

/**
 UITableViewHeaderFooterView subclass that encapsulates the boilerplate code to make self-sizing headers and footers work correctly in a YLTableView
 */
@interface YLTableViewSectionHeaderFooterView : UITableViewHeaderFooterView

/**
 Position of this header/footer in the table view
 */
@property (readonly, assign, nonatomic) YLTableViewSectionHeaderFooterPosition position;

/**
 If YES, this instance is being used as a sizing header/footer and won't actually be displayed on screen.
 */
@property (readonly, assign, nonatomic, getter=isSizingView) BOOL sizingView;

@end
