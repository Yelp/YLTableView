//
//  YLExampleImagesCell.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleImagesCell.h"

#import "YLExampleImagesCellModel.h"
#import "YLExampleImagesViewController.h"

#import <YLTableView/YLTableViewChildViewControllerCell.h>

@interface YLExampleImagesCell () <YLTableViewChildViewControllerCell>
@property (strong, nonatomic) YLExampleImagesViewController *imagesViewController;
@end

@implementation YLExampleImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _imagesViewController = [[YLExampleImagesViewController alloc] init];
    _imagesViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_imagesViewController.view];
    
    [self _installConstraints];
  }
  return self;
}

#pragma mark Layout

- (void)_installConstraints {
  // Make sure we display the controller's view
  NSDictionary *views = @{ @"view": self.imagesViewController.view };
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
}

#pragma mark YLTableViewCell subclass

- (void)setModel:(id)model {
  NSAssert([model isKindOfClass:[YLExampleImagesCellModel class]], @"Must use %@ with %@", NSStringFromClass([YLExampleImagesCellModel class]), NSStringFromClass([self class]));
  // Pass the images through to the controller
  YLExampleImagesCellModel *imagesModel = (YLExampleImagesCellModel *)model;
  self.imagesViewController.imageOne = imagesModel.imageOne;
  self.imagesViewController.imageTwo = imagesModel.imageTwo;
  self.imagesViewController.imageThree = imagesModel.imageThree;
}

#pragma mark YLTableViewChildViewControllerCell

- (YLExampleImagesViewController *)childViewController {
  // By returning a child view controller here, it'll be added as a child of YLExampleViewController and recieve view events + access to the navigation controller.
  return self.imagesViewController;
}

@end
