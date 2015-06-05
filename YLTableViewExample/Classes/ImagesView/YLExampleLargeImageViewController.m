//
//  YLExampleLargeImageViewController.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleLargeImageViewController.h"

@interface YLExampleLargeImageViewController ()
@property (strong, nonatomic) UIImage *image;
@end

@implementation YLExampleLargeImageViewController

- (instancetype)initWithImage:(UIImage *)image {
  if (self = [super init]) {
    _image = image;
  }
  return self;
}

- (void)loadView {
  [super loadView];
  UIImageView *imageView = [[UIImageView alloc] init];
  imageView.image = self.image;
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  imageView.backgroundColor = [UIColor whiteColor];
  self.view = imageView;
}

@end
