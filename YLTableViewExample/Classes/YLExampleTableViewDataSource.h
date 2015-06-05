//
//  YLExampleTableViewDataSource.h
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableViewDataSource.h"

@class YLExampleTableViewDataSource;
@class YLExampleImagesCellModel;

@protocol YLExampleTableViewDataSourceDelegate <NSObject>
- (void)exampleTableViewDataSource:(YLExampleTableViewDataSource *)dataSource didSelectImagesModel:(YLExampleImagesCellModel *)imagesModel;
@end

@interface YLExampleTableViewDataSource : YLTableViewDataSource

@property (weak, nonatomic) id<YLExampleTableViewDataSourceDelegate> delegate;

@end
