//
//  YLRefreshHeaderView.m
//  YLTableView
//
//  Created by Mason Glidden on 7/31/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLRefreshHeaderView.h"
#import "YLRefreshHeaderViewPrivate.h"
#import "YLRefreshHeaderViewSubclass.h"

@implementation YLRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
    self.refreshState = YLRefreshHeaderViewStateNormal;
  }
  return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
  static const CGFloat bottomPadding = 2;
  return CGSizeMake(size.width, self.pullAmountToRefresh + bottomPadding);
}

- (void)setRefreshState:(YLRefreshHeaderViewState)refreshState {
  [self setRefreshState:refreshState animated:YES];
}

- (void)setRefreshState:(YLRefreshHeaderViewState)refreshState animated:(BOOL)animated {
  _refreshState = refreshState;

  void (^animationBlock)(void) = ^{
    UIScrollView *strongScrollView = self.scrollView;
    UIEdgeInsets contentInset = strongScrollView.contentInset;
    // TODO(mglidden): make this support view controllers that have UIRectEdgeTop
    contentInset.top = (refreshState == YLRefreshHeaderViewStateRefreshing) ? self.pullAmountToRefresh : 0;
    strongScrollView.contentInset = contentInset;
  };
  void (^completionBlock)(BOOL) = ^(BOOL finished) {
    if (self.refreshState == YLRefreshHeaderViewStateClosing) {
      self.refreshState = YLRefreshHeaderViewStateNormal;
    }
  };
  
  if (animated) {
    [UIView animateWithDuration:0.2 animations:animationBlock completion:completionBlock];
  } else {
    animationBlock();
    completionBlock(YES);
  }
}

- (CGFloat)pullAmountToRefresh {
  NSAssert(NO, @"Abstract method – subclasses must implement this.");
  return 0;
}

#pragma mark UIScrollViewDelegate

- (void)containingScrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView.isDragging) {
    // If we were ready to refresh but then dragged back up, cancel the Ready to Refresh state.
    if (self.refreshState == YLRefreshHeaderViewStateReadyToRefresh && scrollView.contentOffset.y > -self.pullAmountToRefresh && scrollView.contentOffset.y < 0) {
      self.refreshState = YLRefreshHeaderViewStateNormal;
    // If we've dragged far enough, put us in the Ready to Refresh state
    } else if (self.refreshState == YLRefreshHeaderViewStateNormal && scrollView.contentOffset.y <= -self.pullAmountToRefresh) {
      self.refreshState = YLRefreshHeaderViewStateReadyToRefresh;
    }
  }
  self.currentPullAmount = MAX(0, -scrollView.contentOffset.y);
}

- (void)containingScrollViewDidEndDragging:(UIScrollView *)scrollView {
  // Trigger the action if it was pulled far enough.
  if (scrollView.contentOffset.y <= -self.pullAmountToRefresh &&  self.refreshState != YLRefreshHeaderViewStateRefreshing) {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  } else {
    self.currentPullAmount = 0;
  }
}

@end
