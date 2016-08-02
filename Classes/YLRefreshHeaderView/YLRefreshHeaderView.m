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

@interface YLRefreshHeaderView ()
@property (assign, nonatomic) CGFloat previousTopInset;
@end

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
  if (_refreshState != refreshState) {
    _refreshState = refreshState;
    
    void (^animationBlock)() = ^{
      UIScrollView *strongScrollView = self.scrollView;
      UIEdgeInsets contentInset = strongScrollView.contentInset;
      switch (refreshState) {
        case YLRefreshHeaderViewStateRefreshing:
          self.previousTopInset = contentInset.top;
          contentInset.top = self.pullAmountToRefresh + MAX(self.previousTopInset, 0);
          break;
        case YLRefreshHeaderViewStateClosing:
        case YLRefreshHeaderViewStateNormal:
          contentInset.top = self.previousTopInset;
        default:
          break;
      }
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
}

- (CGFloat)pullAmountToRefresh {
  NSAssert(NO, @"Abstract method – subclasses must implement this.");
  return 0;
}

- (CGFloat)relativeYContentOffsetForScrollView:(UIScrollView *)scrollView{
  return scrollView.contentOffset.y + MAX(scrollView.contentInset.top, 0);
}

#pragma mark UIScrollViewDelegate

- (void)containingScrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView.isDragging) {
    // If we were ready to refresh but then dragged back up, cancel the Ready to Refresh state.
    if (self.refreshState == YLRefreshHeaderViewStateReadyToRefresh && [self relativeYContentOffsetForScrollView:scrollView] > -self.pullAmountToRefresh && [self relativeYContentOffsetForScrollView:scrollView] < 0) {
      self.refreshState = YLRefreshHeaderViewStateNormal;
    // If we've dragged far enough, put us in the Ready to Refresh state
    } else if (self.refreshState == YLRefreshHeaderViewStateNormal && [self relativeYContentOffsetForScrollView:scrollView] <= -self.pullAmountToRefresh) {
      self.refreshState = YLRefreshHeaderViewStateReadyToRefresh;
    }
  }
  self.currentPullAmount = MAX(0, -[self relativeYContentOffsetForScrollView:scrollView]);
}

- (void)containingScrollViewDidEndDragging:(UIScrollView *)scrollView {
  // Trigger the action if it was pulled far enough.
  if ([self relativeYContentOffsetForScrollView:scrollView] <= -self.pullAmountToRefresh &&  self.refreshState != YLRefreshHeaderViewStateRefreshing) {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  } else {
    self.currentPullAmount = 0;
  }
}

@end
