//
//  YLTableViewSectionHeaderFooterLabelView.m
//  YLTableView
//
//  Created by Tom Abraham on 7/2/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableViewSectionHeaderFooterLabelView.h"

#import "YLTableViewSectionHeaderFooterViewSubclass.h"

@implementation YLTableViewSectionHeaderFooterLabelView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentLayoutGuideView addSubview:_label];

    [self _installLabelConstraints];
  }
  return self;
}

#pragma mark Layout

- (void)_installLabelConstraints {
  NSDictionary *views = NSDictionaryOfVariableBindings(_label);

  [self.contentLayoutGuideView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]|" options:0 metrics:nil views:views]];
  [self.contentLayoutGuideView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_label]|" options:0 metrics:nil views:views]];
}

#pragma mark Text property

- (void)setText:(NSString *)text {
  self.label.text = text;
}

- (NSString *)text {
  return self.label.text;
}

@end