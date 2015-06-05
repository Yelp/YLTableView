//
//  YLExampleImageCellViewController.h
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

//! View controller that displays 3 images and opens a detail view when one is selected. In this project, it is used in a cell and pushed onto the navigation controller by itself.
@interface YLExampleImagesViewController : UIViewController

@property (strong, nonatomic) UIImage *imageOne;
@property (strong, nonatomic) UIImage *imageTwo;
@property (strong, nonatomic) UIImage *imageThree;

@end
