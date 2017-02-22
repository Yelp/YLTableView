//
//  YLRefreshHeaderViewPrivate.h
//  YLTableView
//
//  Created by Mason Glidden on 8/19/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLRefreshHeaderView.h"

/**
 Methods used by YLTableViewDataSource and YLTableView to make the refresh header work.
*/
NS_ASSUME_NONNULL_BEGIN
@interface YLRefreshHeaderView ()

/**
 The scroll view that this refresh header is at the top of.
 */
@property (weak, nonatomic) UIScrollView *scrollView;

/**
 Called from scrollViewDidScroll: to update the refresh header
 */
- (void)containingScrollViewDidScroll:(UIScrollView *)scrollView;

/**
 Called from scrollViewDidEndDragging: to potentially start the refresh
 */
- (void)containingScrollViewDidEndDragging:(UIScrollView *)scrollView;

@end
NS_ASSUME_NONNULL_END
