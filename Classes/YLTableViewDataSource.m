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
#import "YLTableViewChildViewControllerCell.h"
#import "YLTableViewSectionHeaderFooterView.h"
#import "YLTableViewSectionHeaderFooterViewPrivate.h"

@interface YLTableViewDataSource ()

//! This is used to cache the estimated row heights.
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSNumber *> * indexPathToEstimatedRowHeight;

@end

@implementation YLTableViewDataSource


#pragma mark indexPathToEstimatedRowHeight property methods

- (NSMutableDictionary<NSString *,NSNumber *> *)indexPathToEstimatedRowHeight {
  if (!_indexPathToEstimatedRowHeight) {
    _indexPathToEstimatedRowHeight = [[NSMutableDictionary alloc] init];
  }

  return _indexPathToEstimatedRowHeight;
}

#pragma mark Public Helpers

- (void)reloadVisibleCellForModel:(id)model inTableView:(UITableView *)tableView {
  for (NSIndexPath *indexPath in [tableView indexPathsForVisibleRows]) {
    if ([self tableView:tableView modelForCellAtIndexPath:indexPath] == model) {
      [(UITableViewCell<YLTableViewCell> *)[tableView cellForRowAtIndexPath:indexPath] setModel:model];
      return;
    }
  }
}

#pragma mark Private Helpers

//! Constructs a cache key for the given index path. UITableView sometimes returns a different subclass, NSMutableIndexPath, so we can't use the index path as the key by itself.
+ (NSString *)_keyForIndexPath:(NSIndexPath *)indexPath {
  return [NSString stringWithFormat:@"%ld,%ld", (long)indexPath.section, (long)indexPath.row];
}

#pragma mark Configuration

- (void)tableView:(UITableView *)tableView configureCell:(UITableViewCell<YLTableViewCell> *)cell forIndexPath:(NSIndexPath *)indexPath {
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

- (id)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
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
  UITableViewCell<YLTableViewCell> *cell = (UITableViewCell<YLTableViewCell> *)[tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
  NSAssert([[cell class] conformsToProtocol:@protocol(YLTableViewCell)], @"You can only use cells conforming to YLTableViewCell.");
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
  return UITableViewAutomaticDimension;
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
    return 0;
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
    return 0;
  }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSAssert([tableView isKindOfClass:[YLTableView class]], @"This can only be the delegate of a YLTableView.");

  if (self.shouldCacheEstimatedRowHeights && self.indexPathToEstimatedRowHeight[[[self class] _keyForIndexPath:indexPath]]) {
      return [self.indexPathToEstimatedRowHeight[[[self class] _keyForIndexPath:indexPath]] floatValue];
  }
  id model = [self tableView:tableView modelForCellAtIndexPath:indexPath];
  return [self tableView:tableView estimatedHeightForRowAtIndexPath:indexPath withModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath withModel:(id)model {
  Class cellClass = [(YLTableView *)tableView cellClassForReuseIdentifier:[self tableView:tableView reuseIdentifierForCellAtIndexPath:indexPath]];
  NSAssert([cellClass conformsToProtocol:@protocol(YLTableViewCell)], @"You can only use cells conforming to YLTableViewCell.");
  return [(id<YLTableViewCell>)cellClass estimatedRowHeight];
}

#pragma mark ChildViewController support

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

  if (self.shouldCacheEstimatedRowHeights) {
    self.indexPathToEstimatedRowHeight[[[self class] _keyForIndexPath:indexPath]] = @(cell.frame.size.height);
  }

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