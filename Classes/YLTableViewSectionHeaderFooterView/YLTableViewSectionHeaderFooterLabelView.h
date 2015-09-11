//
//  YLTableViewSectionHeaderFooterLabelView.h
//  YLTableView
//
//  Created by Tom Abraham on 7/2/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableViewSectionHeaderFooterView.h"

NS_ASSUME_NONNULL_BEGIN
//! A section header / footer view that supports a single, multi-line label
@interface YLTableViewSectionHeaderFooterLabelView : YLTableViewSectionHeaderFooterView

//! We don't use the default textLabel because then this header/footer would be sized assuming the system default header/footer font.
@property (readonly, strong, nonatomic) UILabel *label;

//! Setting this property will set the label's text.
@property (copy, nonatomic, nullable) NSString *text;

@end
NS_ASSUME_NONNULL_END
