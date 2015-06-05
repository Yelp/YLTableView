//
//  YLExampleImageCellViewController.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleImagesViewController.h"

#import "YLExampleImagesView.h"
#import "YLExampleLargeImageViewController.h"

@interface YLExampleImagesViewController () <YLExampleImageCellViewDelegate>
@property (strong, nonatomic) YLExampleImagesView *imageCellView;
@end

@implementation YLExampleImagesViewController

- (void)loadView {
  [super loadView];
  self.view = self.imageCellView;
}

- (YLExampleImagesView *)imageCellView {
  if (!_imageCellView) {
    _imageCellView = [[YLExampleImagesView alloc] init];
    _imageCellView.delegate = self;
  }
  return _imageCellView;
}

#pragma mark YLExampleImageCellViewDelegate

- (void)exampleImageCellView:(YLExampleImagesView *)exampleImageCellView didSelectImage:(UIImage *)image {
  [self.navigationController pushViewController:[[YLExampleLargeImageViewController alloc] initWithImage:image] animated:YES];
}

#pragma mark Public methods

- (UIImage *)imageOne {
  return self.imageCellView.imageOne;
}

- (void)setImageOne:(UIImage *)imageOne {
  self.imageCellView.imageOne = imageOne;
}

- (UIImage *)imageTwo {
  return self.imageCellView.imageTwo;
}

- (void)setImageTwo:(UIImage *)imageTwo {
  self.imageCellView.imageTwo = imageTwo;
}

- (UIImage *)imageThree {
  return self.imageCellView.imageThree;
}

- (void)setImageThree:(UIImage *)imageThree {
  self.imageCellView.imageThree = imageThree;
}

@end
