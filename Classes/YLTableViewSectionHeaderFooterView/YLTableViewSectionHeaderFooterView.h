//
//  YLTableViewSectionHeaderFooterView.h
//  YLTableView
//
//  Created by Tom Abraham on 11/11/13.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YLTableViewSectionHeaderFooterPosition) {
  YLTableViewSectionHeaderFooterPositionUndefined,
  YLTableViewSectionHeaderFooterPositionHeader, // Any header but the first one in the table view
  YLTableViewSectionHeaderFooterPositionFirstHeader, // The first header in the table view
  YLTableViewSectionHeaderFooterPositionFooter, // Any footer but the last on one in the table view
  YLTableViewSectionHeaderFooterPositionLastFooter, // The last footer in the table view
};

@interface YLTableViewSectionHeaderFooterView : UITableViewHeaderFooterView

//! Position of this header/footer in the table view
@property (readonly, assign, nonatomic) YLTableViewSectionHeaderFooterPosition position;

//! If YES, this instance is being used as a sizing header/footer and won't actually be displayed on screen.
@property (readonly, assign, nonatomic, getter=isSizingView) BOOL sizingView;

@end
