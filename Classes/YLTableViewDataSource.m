//
//  YLTableViewDataSource.m
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLTableViewDataSource.h"
#import "YLTableViewDataSourceSubclass.h"

#import "YLRefreshHeaderViewPrivate.h"
#import "YLTableView.h"
#import "YLTableViewPrivate.h"
#import "YLTableViewCell.h"
#import "YLTableViewCellPrivate.h"
#import "YLTableViewChildViewControllerCell.h"
#import "YLTableViewSectionHeaderFooterView.h"
#import "YLTableViewSectionHeaderFooterViewPrivate.h"

@implementation YLTableViewDataSource

#pragma mark Public Helpers

- (void)reloadVisibleCellForModel:(NSObject *)model inTableView:(UITableView *)tableView {
  for (NSIndexPath *indexPath in [tableView indexPathsForVisibleRows]) {
    if ([self tableView:tableView modelForCellAtIndexPath:indexPath] == model) {
      [(YLTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] setModel:model];
      return;
    }
  }
}

#pragma mark Configuration

- (void)tableView:(UITableView *)tableView configureCell:(YLTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
  [cell setModel:[self tableView:tableView modelForCellAtIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView configureHeader:(YLTableViewSectionHeaderFooterView *)headerView forSection:(NSUInteger)section {
  headerView.position = section == 0 ? YLTableViewSectionHeaderFooterPositionFirstHeader : YLTableViewSectionHeaderFooterPositionHeader;
}

- (void)tableView:(UITableView *)tableView configureFooter:(YLTableViewSectionHeaderFooterView *)footerView forSection:(NSUInteger)section {
  footerView.position = (section == [tableView numberOfSections] - 1) ? YLTableViewSectionHeaderFooterPositionLastFooter : YLTableViewSectionHeaderFooterPositionFooter;
}

#pragma mark Reuse Identifiers

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert(NO, @"Must have a reuse identifier for all rows.");
  return nil;
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForHeaderInSection:(NSUInteger)section {
  return nil;
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForFooterInSection:(NSUInteger)section {
  return nil;
}

#pragma mark Models

- (NSObject *)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert(NO, @"Must have a model for all rows.");
  return nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSAssert(NO, @"This is abstract.");
  return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *const reuseID = [self tableView:tableView reuseIdentifierForCellAtIndexPath:indexPath];
  NSAssert(reuseID != nil, @"Must have a reuse identifier.");
  YLTableViewCell *cell = (YLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
  [self tableView:tableView configureCell:cell forIndexPath:indexPath];
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  NSString *const reuseID = [self tableView:tableView reuseIdentifierForHeaderInSection:section];

  if (reuseID == nil) {
    return nil;
  }
  
  YLTableViewSectionHeaderFooterView *headerView = (YLTableViewSectionHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
  headerView.sizingView = NO;
  [self tableView:tableView configureHeader:headerView forSection:section];
  return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  NSString *const reuseID = [self tableView:tableView reuseIdentifierForFooterInSection:section];

  if (reuseID == nil) {
    return nil;
  }
  
  YLTableViewSectionHeaderFooterView *footerView = (YLTableViewSectionHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
  footerView.sizingView = NO;
  [self tableView:tableView configureFooter:footerView forSection:section];
  return footerView;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert([tableView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");
  
  if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    return UITableViewAutomaticDimension;
  }
  
  NSString *const reuseID = [self tableView:tableView reuseIdentifierForCellAtIndexPath:indexPath];
  YLTableViewCell *cell = [(YLTableView *)tableView sizingCellForReuseIdentifier:reuseID];
  [self tableView:tableView configureCell:cell forIndexPath:indexPath];
  
  return [cell heightForWidth:CGRectGetWidth(tableView.bounds) separatorStyle:tableView.separatorStyle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  NSAssert([tableView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");

  NSString *const reuseID = [self tableView:tableView reuseIdentifierForHeaderInSection:section];
  if (reuseID) {
    YLTableViewSectionHeaderFooterView *headerView = [(YLTableView *)tableView sizingHeaderFooterViewForReuseIdentifier:reuseID];
    headerView.sizingView = YES;
    [self tableView:tableView configureHeader:headerView forSection:section];
    return [headerView heightForWidth:CGRectGetWidth(tableView.bounds)];
  } else {
    return UITableViewAutomaticDimension;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  NSAssert([tableView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");

  NSString *const reuseID = [self tableView:tableView reuseIdentifierForFooterInSection:section];
  if (reuseID) {
    YLTableViewSectionHeaderFooterView *footerView = [(YLTableView *)tableView sizingHeaderFooterViewForReuseIdentifier:reuseID];
    footerView.sizingView = YES;
    [self tableView:tableView configureFooter:footerView forSection:section];
    return [footerView heightForWidth:CGRectGetWidth(tableView.bounds)];
  } else {
    return UITableViewAutomaticDimension;
  }
}

#pragma mark ChildViewController support

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  UIViewController *parentViewController = self.parentViewController;
  if ([cell conformsToProtocol:@protocol(YLTableViewChildViewControllerCell)]) {
    NSAssert(parentViewController != nil, @"Must have a parent view controller to support cell %@", cell);
    UITableViewCell<YLTableViewChildViewControllerCell> *viewControllerCell = (UITableViewCell<YLTableViewChildViewControllerCell> *)cell;
    UIViewController *childViewController = [viewControllerCell childViewController];
    [parentViewController addChildViewController:childViewController];
    [childViewController didMoveToParentViewController:parentViewController];
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell conformsToProtocol:@protocol(YLTableViewChildViewControllerCell)]) {
    NSAssert(self.parentViewController != nil, @"Must have a parent view controller to support cell %@", cell);
    UITableViewCell<YLTableViewChildViewControllerCell> *viewControllerCell = (UITableViewCell<YLTableViewChildViewControllerCell> *)cell;
    UIViewController *childViewController = [viewControllerCell childViewController];
    [childViewController willMoveToParentViewController:nil];
    [childViewController removeFromParentViewController];
  }
}

#pragma mark UIScrollViewDelegate

// NOTE: The following methods inform a refresh header view of the scrolling behavior of the tableview.  This makes our refresh headers work.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  NSAssert([scrollView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");
  YLRefreshHeaderView *refreshHeaderView = [(YLTableView *)scrollView refreshHeaderView];
  if (refreshHeaderView) {
    NSAssert([refreshHeaderView isKindOfClass:[YLRefreshHeaderView class]], @"The refresh header view must be a subclass of YLRefreshHeaderView.");
    [refreshHeaderView containingScrollViewDidScroll:scrollView];
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  NSAssert([scrollView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");
  YLRefreshHeaderView *refreshHeaderView = [(YLTableView *)scrollView refreshHeaderView];
  if (refreshHeaderView) {
    NSAssert([refreshHeaderView isKindOfClass:[YLRefreshHeaderView class]], @"The refresh header view must be a subclass of YLRefreshHeaderView.");
    [refreshHeaderView containingScrollViewDidEndDragging:scrollView];
  }
}

@end