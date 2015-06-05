//
//  YLExampleImagesCellModel.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleImagesCellModel.h"

@interface  YLExampleImagesCellModel ()
@property (strong, nonatomic) UIImage *imageOne;
@property (strong, nonatomic) UIImage *imageTwo;
@property (strong, nonatomic) UIImage *imageThree;
@end

@implementation YLExampleImagesCellModel

+ (instancetype)modelWithImageOne:(UIImage *)imageOne imageTwo:(UIImage *)imageTwo imageThree:(UIImage *)imageThree {
  YLExampleImagesCellModel *model = [[self alloc] init];
  model.imageOne = imageOne;
  model.imageTwo = imageTwo;
  model.imageThree = imageThree;
  return model;
}

@end
