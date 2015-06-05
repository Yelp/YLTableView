//
//  YLExampleRefreshHEader.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/3/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleRefreshHeader.h"
#import <YLTableView/YLRefreshHeaderViewSubclass.h>

@interface YLExampleRefreshHeader ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation YLExampleRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];

    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];

    NSDictionary *views = NSDictionaryOfVariableBindings(_label);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_label]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-10-|" options:0 metrics:nil views:views]];

    [self setRefreshState:YLRefreshHeaderViewStateNormal];
  }
  return self;
}

#pragma mark YLRefreshHeader subclass methods

- (void)setRefreshState:(YLRefreshHeaderViewState)refreshState animated:(BOOL)animated {
  [super setRefreshState:refreshState animated:animated];

  switch (refreshState) {
    case YLRefreshHeaderViewStateNormal:
      self.label.text = @"Pull to refresh...";
      self.label.textColor = [UIColor redColor];
      break;
    case YLRefreshHeaderViewStateClosing:
    case YLRefreshHeaderViewStateRefreshing:
      self.label.text = @"Refreshing...";
      self.label.textColor = [UIColor blackColor];
      break;
    case YLRefreshHeaderViewStateReadyToRefresh:
      self.label.text = @"Release to refresh";
      self.label.textColor = [UIColor greenColor];
      break;
  }
}

- (CGFloat)pullAmountToRefresh {
  return 40.0;
}

@end
