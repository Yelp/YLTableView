//
//  YLTableView.m
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLTableView.h"
#import "YLTableViewPrivate.h"

#import "YLRefreshHeaderView.h"
#import "YLRefreshHeaderViewPrivate.h"
#import "YLTableViewCell.h"
#import "YLTableViewDataSource.h"
#import "YLTableViewSectionHeaderFooterView.h"

NS_ASSUME_NONNULL_BEGIN
@interface YLTableView ()

//! Maps reuse identifiers to header/footer view class strings
@property (strong, nonatomic) NSMutableDictionary *headerFooterViewClassForReuseIdentifier;
//! Maps reuse identifiers to sizing header/footer views
@property (strong, nonatomic) NSMutableDictionary *sizingHeaderFooterViewsForReuseIdentifier;

@end
NS_ASSUME_NONNULL_END

@implementation YLTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
  if ((self = [super initWithFrame:frame style:style])) {
    _headerFooterViewClassForReuseIdentifier = [NSMutableDictionary dictionary];
    _sizingHeaderFooterViewsForReuseIdentifier = [NSMutableDictionary dictionary];
  }
  return self;
}

#pragma mark Sizing Views

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
  NSAssert(identifier, @"Must have a reuse identifier.");
  NSAssert([cellClass conformsToProtocol:@protocol(YLTableViewCell)], @"You can only use cells conforming to YLTableViewCell.");
  [super registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerClass:(Class)headerFooterViewClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
  NSAssert(identifier, @"Must have a reuse identifier.");
  NSAssert([headerFooterViewClass isSubclassOfClass:[YLTableViewSectionHeaderFooterView class]], @"You can only use subclasses of YLTableViewSectionHeaderFooterView.");

  [super registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:identifier];

  if (headerFooterViewClass) {
    self.headerFooterViewClassForReuseIdentifier[identifier] = NSStringFromClass(headerFooterViewClass);
  } else {
    [self.headerFooterViewClassForReuseIdentifier removeObjectForKey:identifier];
  }
}

- (YLTableViewSectionHeaderFooterView *)sizingHeaderFooterViewForReuseIdentifier:(NSString *)reuseIdentifier {
  NSAssert(reuseIdentifier, @"Must have a reuse identifier.");
  NSAssert(self.headerFooterViewClassForReuseIdentifier[reuseIdentifier], @"You must register a class for this reuse identifier.");

  if (!self.sizingHeaderFooterViewsForReuseIdentifier[reuseIdentifier]) {
    Class headerFooterViewClass = NSClassFromString(self.headerFooterViewClassForReuseIdentifier[reuseIdentifier]);
    YLTableViewSectionHeaderFooterView *const sizingHeaderFooterView = [(YLTableViewSectionHeaderFooterView *)[headerFooterViewClass alloc] initWithReuseIdentifier:reuseIdentifier];
    self.sizingHeaderFooterViewsForReuseIdentifier[reuseIdentifier] = sizingHeaderFooterView;
  }
  return self.sizingHeaderFooterViewsForReuseIdentifier[reuseIdentifier];
}

#pragma mark YLRefreshHeaderView

- (void)layoutSubviews {
  [super layoutSubviews];
  
  // Put self.refreshHeaderView above the origin of self.frame. We set self.refreshHeaderView.frame.size to be equal to self.frame.size to gurantee that you won't be able to see beyond the top of the header view.
  // self.refreshHeaderView should draw it's content at the bottom of its frame.
  self.refreshHeaderView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setRefreshHeaderView:(YLRefreshHeaderView *)refreshHeaderView {
  if (refreshHeaderView) {
    [self addSubview:refreshHeaderView];
    [self sendSubviewToBack:refreshHeaderView];
    self.showsVerticalScrollIndicator = YES;
    refreshHeaderView.scrollView = self;
  } else {
    [self.refreshHeaderView removeFromSuperview];
  }
  _refreshHeaderView = refreshHeaderView;
}

#pragma mark State

- (void)setState:(YLTableViewState)state {
  YLRefreshHeaderViewState newState = YLRefreshHeaderViewStateNormal;
  if (state == YLTableViewStateRefreshing) {
    newState = YLRefreshHeaderViewStateRefreshing;
  } else if (self.refreshHeaderView.refreshState == YLRefreshHeaderViewStateRefreshing) {
    newState = YLRefreshHeaderViewStateClosing;
  }
  self.refreshHeaderView.refreshState = newState;
  
  _state = state;
}

@end
