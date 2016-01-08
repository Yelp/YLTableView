//
//  YLExampleTextCell.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleTextCell.h"

#import <YLTableView/YLTableViewCell.h>

@interface YLExampleTextCell ()
@property (strong, nonatomic) UILabel *mainTextLabel;
@end

@implementation YLExampleTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    // Apple's default label doesn't support multi-line content very well, so we'll add our own label
    _mainTextLabel = [[UILabel alloc] init];
    _mainTextLabel.font = [UIFont systemFontOfSize:16.0];
    _mainTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _mainTextLabel.numberOfLines = 0;
    [self.contentView addSubview:_mainTextLabel];
    
    [self _installConstraints];
  }
  return self;
}

#pragma mark Layout

- (void)_installConstraints {
  NSDictionary *views = NSDictionaryOfVariableBindings(_mainTextLabel);
  NSDictionary *metrics = @{ @"margin": @10, };
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_mainTextLabel]-margin-|" options:0 metrics:metrics views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_mainTextLabel]-margin-|" options:0 metrics:metrics views:views]];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  // iOS8 automatically handles this for us.
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
    self.mainTextLabel.preferredMaxLayoutWidth = self.mainTextLabel.frame.size.width;
    [super layoutSubviews];
  }
}

#pragma mark YLTableViewCell protocol

- (void)setModel:(id)model {
  NSAssert([model isKindOfClass:[NSString class]], @"Must use %@ with %@", NSStringFromClass([NSString class]), NSStringFromClass([self class]));
  self.mainTextLabel.text = (NSString *)model;
}

+ (CGFloat)estimatedRowHeight {
  return 44.0;
}

@end
