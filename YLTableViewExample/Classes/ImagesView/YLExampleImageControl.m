//
//  YLExampleImageControl.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleImageControl.h"

@interface YLExampleImageControl ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation YLExampleImageControl

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    
    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:views]];
}

- (void)setImage:(UIImage *)image {
  self.imageView.image = image;
}

- (UIImage *)image {
  return self.imageView.image;
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  self.backgroundColor = highlighted ? [UIColor grayColor] : [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  self.backgroundColor = selected ? [UIColor grayColor] : [UIColor clearColor];
}

@end
