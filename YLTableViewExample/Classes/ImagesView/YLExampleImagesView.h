//
//  YLExampleImageCellView.h
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLExampleImagesView;

@protocol YLExampleImageCellViewDelegate <NSObject>
- (void)exampleImageCellView:(YLExampleImagesView *)exampleImageCellView didSelectImage:(UIImage *)image;
@end

@interface YLExampleImagesView : UIView

@property (strong, nonatomic) UIImage *imageOne;
@property (strong, nonatomic) UIImage *imageTwo;
@property (strong, nonatomic) UIImage *imageThree;

@property (weak, nonatomic) id<YLExampleImageCellViewDelegate> delegate;

@end
