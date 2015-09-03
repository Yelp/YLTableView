//
//  YPUITableViewHeaderFooterView.h
//  YLTableView
//
//  Created by Tom Abraham on 5/13/14.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*! YPUITableViewHeaderFooterView is wrapper view that is to be used as the table{Header/Footer}View of
 *  a UITableView. The one piece of functionality it offers is for UIViews with Auto Layout constraints
 *  to be used as table{Header/Footer}Views in such a way that if their content changes, the height
 *  of the table{Header/Footer}View will be updated to reflect the change in the height of the content.
 *
 *  They can be used as such:
 *
 *    tableView.tableHeaderView = [[YPUITableViewHeaderFooterView alloc] initWithView:actualHeaderView forTableView:tableView];
 *
 *  When UITableView starts to support UIViews with Auto Layout constraints (iOS 8?), the above line can
 *  be replaced simply by:
 *
 *    tableView.tableHeaderView = actualHeaderView;
 */
@interface YLTableViewHeaderFooterView : UIView

/*! @param view        A UIView instance that *must* be sized using Auto Layout constraints. It should
 *                     *not* have its width (unambiguously) defined. Its width will be decided by self.
 *                     On the other hand, its height *should* be unambiguously defined.
 *  @param tableView   The UITableView for which self is going to be a table{Header,Footer}View for i.e.
 *                     tableView.table{Header/Footer}View == self must be true.
 */
- (nullable instancetype)initWithView:(UIView *)view forTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
