//
//  YPUITableViewHeaderFooterView.m
//  YLTableView
//
//  Created by Tom Abraham on 5/13/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableViewHeaderFooterView.h"

@interface YLTableViewHeaderFooterView ()

@property (strong, nonatomic) UIView *view;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation YLTableViewHeaderFooterView

- (instancetype)initWithView:(UIView *)view forTableView:(UITableView *)tableView {
  if (self = [self init]) {
    _view = view;
    [self addSubview:view];

    _tableView = tableView;

    [self _installConstraints];
  }

  return self;
}

#pragma mark Layout

- (void)_installConstraints {
  NSDictionary *views = NSDictionaryOfVariableBindings(_view, self);

  // note how we don't pin self.view to the bottom or right of self
  // this is so that the self.view doesn't have self's autoresizing mask constraints constraining its height or width
  self.view.translatesAutoresizingMaskIntoConstraints = NO;
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_view]" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_view]" options:0 metrics:nil views:views]];
  
  // If we constrained the view to be the same width as us, it would first be sized as 0px wide, which would break a bunch of constraints. We'll put the priority of the width constraint at 999, so our other required constraints override it.
  NSLayoutConstraint *viewWidthConstraint = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_view(==self)]" options:0 metrics:nil views:views] firstObject];
  viewWidthConstraint.priority = UILayoutPriorityRequired - 1;
  [self  addConstraint:viewWidthConstraint];
}

- (void)layoutSubviews {
  // layout (and thus, size) our one subview, self.view
  [super layoutSubviews];
  
  // update our height to match view's height
  // on OS7 and before, UITableViews do *not* like fractional heights for their table{Header/Footer}View.
  // they respond by increasing the space available for the table{Header/Footer}View by the fraction to the
  // nearest whole number on *each* layout pass. thus, we round to the nearest whole number. filed rdar://16909794
  CGRect bounds = self.bounds;
  bounds.size.height = round(CGRectGetHeight(self.view.bounds));
  self.bounds = bounds;
  
  // re-setting the header/footer tells the table view that its height changed
  // it doesn't matter if it hasn't. UITableView is smart enough not to relayout if our height hasn't changed.
  UITableView *tableView = self.tableView;
  if (tableView.tableHeaderView == self) tableView.tableHeaderView = self;
  else if (tableView.tableFooterView == self) tableView.tableFooterView = self;
  
  // we updated our height so we need to relayout our subviews
  [super layoutSubviews];
}

@end
