//
//  YLExampleImagesCellModel.h
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface YLExampleImagesCellModel : NSObject

@property (readonly, strong, nonatomic) UIImage *imageOne;
@property (readonly, strong, nonatomic) UIImage *imageTwo;
@property (readonly, strong, nonatomic) UIImage *imageThree;

+ (instancetype)modelWithImageOne:(UIImage *)imageOne imageTwo:(UIImage *)imageTwo imageThree:(UIImage *)imageThree;

@end
