//
//  YLTableViewDataSourceTestStub.h
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewCell.h"
#import "YLTableViewDataSource.h"

//! If shouldProvideOverriddenHeight, this is the height returned by estimatedHeightForRow:inTableView:
extern const CGFloat kYLTableViewDataSourceTestStubOverriddenHeight;

//! YLTableViewDataSource stub used for testing purposes
@interface YLTableViewDataSourceTestStub : YLTableViewDataSource

//! This is used to populate the table with cells at their respective index paths
@property (copy, nonatomic) NSDictionary<NSIndexPath *, YLTableViewCell* > *tableViewCells;

//! Set to true to override the default height of estimatedHeightForRow:inTableView: to return kYLTableViewDataSourceTestStubOverriddenHeight
@property (assign, nonatomic) BOOL shouldProvideOverriddenHeight;

@end
