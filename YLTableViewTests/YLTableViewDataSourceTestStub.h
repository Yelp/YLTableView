//
//  YLTableViewDataSourceTestStub.h
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewDataSource.h"


/**
 A cell model used by YLTableViewDataSourceTestStub.
 */
@interface YLTableViewCellModelTestStub : NSObject

/**
 The reuse identifier the datasource will return for this model.
 */
@property (copy, nonatomic) NSString *reuseIdentifier;

/**
 An estimated height that may be used by the cell in estimatedRowHeightForModel:.
 */
@property (assign, nonatomic) CGFloat estimatedHeight;

/**
 Create a model with the given reuse identifier and estimated height.
 */
+ (instancetype)modelWithReuseIdentifier:(NSString *)reuseIdentifier estimatedHeight:(CGFloat)estimatedHeight;

@end


/**
 YLTableViewDataSource stub used for testing purposes
 */
@interface YLTableViewDataSourceTestStub : YLTableViewDataSource

/**
 This is used to populate the table with cells at their respective index paths
 */
@property (copy, nonatomic) NSDictionary<NSIndexPath *, YLTableViewCellModelTestStub *> *models;

@end
