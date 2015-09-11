//
//  YLTableViewDataSourceSubclass.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "YLTableViewDataSource.h"

@class YLTableViewCell;
@class YLTableViewSectionHeaderFooterView;

NS_ASSUME_NONNULL_BEGIN
@interface YLTableViewDataSource ()

#pragma mark Abstract methods

//! Abstract method – must be handled by subclass. Return the reuse identifier for the given indexPath.
- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath;

//! Abstract method – must be handled by subclass. The returned model will be passed to the cell for indexPath.
- (NSObject *)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath;


#pragma mark Optional Methods

/*!
 * Return the reuse identifier for the given section header. By default, returns nil, in which case, no header is created.
 *
 * If nil is returned, tableView:heightForHeaderInSection: returns UITableViewAutomaticDimension which results in 17.5pt empty space on OS7.
 */
- (nullable NSString *)tableView:(UITableView *)tableView reuseIdentifierForHeaderInSection:(NSUInteger)section;

/*!
 * Return the reuse identifier for the given section footer. By default, returns nil, in which case, no footer is created.
 *
 * If nil is returned, tableView:heightForFooterInSection: returns UITableViewAutomaticDimension which results in 17.5pt empty space on OS7.
 */
- (nullable NSString *)tableView:(UITableView *)tableView reuseIdentifierForFooterInSection:(NSUInteger)section;

/*!
 * Configure cell for display of the content in indexPath – gets the model for indexPath and then calls setModel on cell.
 *
 * Override this method if you need to do cell-specific configuration (for example, alternating background colors) but call super implementation first.
 */
- (void)tableView:(UITableView *)tableView configureCell:(YLTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

//! Override this method to configure headerView to display content in section but call super implementation first.
- (void)tableView:(UITableView *)tableView configureHeader:(YLTableViewSectionHeaderFooterView *)headerView forSection:(NSUInteger)section NS_REQUIRES_SUPER;

//! Override this method to configure footerView to display content in section but call super implementation first.
- (void)tableView:(UITableView *)tableView configureFooter:(YLTableViewSectionHeaderFooterView *)footerView forSection:(NSUInteger)section NS_REQUIRES_SUPER;


#pragma mark Pull To Refresh support

//! You don't need to implement this, but make sure to call super if you do.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

//! You don't need to implement this, but make sure to call super if you do.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate NS_REQUIRES_SUPER;


#pragma mark ChildViewController support

//! You don't need to implement this, but make sure to call super if you do.
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

//! You don't need to implement this, but make sure to call super if you do.
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end
NS_ASSUME_NONNULL_END
