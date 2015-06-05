//
//  YLExampleImageCellView.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleImagesView.h"

#import "YLExampleImageControl.h"

@interface YLExampleImagesView ()
@property (strong, nonatomic) YLExampleImageControl *imageControlOne;
@property (strong, nonatomic) YLExampleImageControl *imageControlTwo;
@property (strong, nonatomic) YLExampleImageControl *imageControlThree;
@end

@implementation YLExampleImagesView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
    
    _imageControlOne = [[YLExampleImageControl alloc] init];
    _imageControlOne.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageControlOne addTarget:self action:@selector(_controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageControlOne];
    
    _imageControlTwo = [[YLExampleImageControl alloc] init];
    _imageControlTwo.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageControlTwo addTarget:self action:@selector(_controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageControlTwo];
    
    _imageControlThree = [[YLExampleImageControl alloc] init];
    _imageControlThree.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageControlThree addTarget:self action:@selector(_controlSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageControlThree];
    
    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *views = NSDictionaryOfVariableBindings(_imageControlOne, _imageControlTwo, _imageControlThree);
  NSDictionary *metrics = @{ @"margin": @10, @"imageDimension": @60, };
  
  // Space outh the 3 images horizontally, centering the middle one.
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_imageControlOne(imageDimension)]-(>=margin)-[_imageControlTwo(imageDimension)]-(>=margin)-[_imageControlThree(imageDimension)]-margin-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageControlTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
  
  // Center the images vertically
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[_imageControlOne(imageDimension)]-(>=margin)-|" options:0 metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[_imageControlTwo(imageDimension)]-(>=margin)-|" options:0 metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=margin)-[_imageControlThree(imageDimension)]-(>=margin)-|" options:0 metrics:metrics views:views]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageControlOne attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)_controlSelected:(YLExampleImageControl *)control {
  id<YLExampleImageCellViewDelegate> delegate = self.delegate;
  [delegate exampleImageCellView:self didSelectImage:control.image];
}

#pragma mark Public methods

- (UIImage *)imageOne {
  return self.imageControlOne.image;
}

- (void)setImageOne:(UIImage *)imageOne {
  self.imageControlOne.image = imageOne;
}

- (UIImage *)imageTwo {
  return self.imageControlTwo.image;
}

- (void)setImageTwo:(UIImage *)imageTwo {
  self.imageControlTwo.image = imageTwo;
}

- (UIImage *)imageThree {
  return self.imageControlThree.image;
}

- (void)setImageThree:(UIImage *)imageThree {
  self.imageControlThree.image = imageThree;
}

@end
