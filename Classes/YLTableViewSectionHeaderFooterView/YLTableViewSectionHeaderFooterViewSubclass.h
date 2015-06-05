//
//  YLTableViewSectionHeaderFooterViewSubclass.h
//  YLTableView
//
//  Created by Tom Abraham on 7/2/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableViewSectionHeaderFooterView.h"

@interface YLTableViewSectionHeaderFooterView ()

/*!
 * You should add subviews to this view, and pin those views to it using Auto Layout constraints.
 *
 * This view is inset by contentLayoutGuideInsets + _systemContentLayoutGuideInsets. contentLayoutGuideInsets can be overridden by subclasses.
 */
@property (readonly, strong, nonatomic) UIView *contentLayoutGuideView;

@property (readonly, assign, nonatomic) UIEdgeInsets contentLayoutGuideInsets;

@end