//
//  YLTableViewPrivate.h
//  YLTableView
//
//  Created by Mason Glidden on 6/3/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

// NOTE: This header is not actually private. See PR#41: https://github.com/Yelp/YLTableView/pull/41

#import "YLTableView.h"

@class YLTableViewSectionHeaderFooterView;

NS_ASSUME_NONNULL_BEGIN
@interface YLTableView ()

/**
 Returns the cell class registered for this reuse identifier, or Nil if none was registered.
 */
- (nullable Class)cellClassForReuseIdentifier:(NSString *)reuseIdentifier;

/**
 Returns a cached section header/footer view for this reuse identifier. The view should only be used for sizing purposes, not for display.
 */
- (YLTableViewSectionHeaderFooterView *)sizingHeaderFooterViewForReuseIdentifier:(NSString *)reuseIdentifier;

@end
NS_ASSUME_NONNULL_END
