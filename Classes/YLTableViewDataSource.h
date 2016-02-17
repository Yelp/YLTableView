//
//  YLTableViewDataSource.h
//  YLTableView
//
//  Created by Mason Glidden on 6/10/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLRefreshHeaderView;

NS_ASSUME_NONNULL_BEGIN
/**
 Class that conforms to UITableViewDataSource and UITableViewDelegate to be subclassed by clients of YLTableView. This class contains the boilerplate for mapping cell models to cells, along with other boilerplate code that makes YLTableView easy to use. See YLTableViewDataSourceSubclass for more info.
 */
@interface YLTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

/**
 If one of model's properties has changed (but it's still the same object), this will reload the visible cell for that model. Useful whenever something mutates the state of a model (i.e. image loading)
 */
- (void)reloadVisibleCellForModel:(id)model inTableView:(UITableView *)tableView;

/**
 Set as the parent view controller of any cells implementing YLTableViewChildViewControllerCell.
 */
@property (weak, nonatomic, nullable) UIViewController *parentViewController;

/**
 Defaults to NO. If you would like to cache the estimated heights for rows, set this to YES.

 @note This is only really necessary for iOS 8. If you are using estimated row height + UITableViewAutomaticDimension in iOS 8, there's a bug
 when reloadData is called: if the estimated height is different from the real height for the cells, the table view will jump when you scroll
 after calling reloadData. To fix this, we can record the actual height as it comes on screen (willDisplayCell), and return this for the
 estimated row height. This bug is fixed in iOS 9.
 */
@property (assign, nonatomic) BOOL shouldCacheEstimatedRowHeights;

@end
NS_ASSUME_NONNULL_END
