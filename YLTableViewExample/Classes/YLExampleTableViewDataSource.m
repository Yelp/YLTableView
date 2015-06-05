//
//  YLExampleTableViewDataSource.m
//  YLTableViewExample
//
//  Created by Mason Glidden on 6/2/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLExampleTableViewDataSource.h"

#import "YLExampleTextCell.h"
#import "YLExampleImagesCell.h"
#import "YLExampleImagesCellModel.h"

#import <YLTableView/YLTableViewDataSourceSubclass.h>
#import <YLTableView/YLTableViewSectionHeaderFooterLabelView.h>

typedef NS_ENUM(NSInteger, YLExampleTableViewSection) {
  YLExampleTableViewSectionText = 0,
  YLExampleTableViewSectionImages,
};

@interface YLExampleTableViewDataSource ()
@property (copy, nonatomic) NSArray *sectionModels;
@end

@implementation YLExampleTableViewDataSource

- (instancetype)init {
  if (self = [super init]) {
    // We usually use a model factory to create the models, but this is a small enough example that it can be done inline.
    _sectionModels = @[
                       @[@"cell one", @"cell two", @"really long text cell that will stretch to multiple lines, even on a wide phone like the iPhone 6+."],
                       @[[YLExampleImagesCellModel modelWithImageOne:[UIImage imageNamed:@"ninja_hammy.png"] imageTwo:[UIImage imageNamed:@"star.png"] imageThree:[UIImage imageNamed:@"yelp_logo.png"]]],
                       ];
  }
  return self;
}

#pragma mark YLTableViewDataSource subclass

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  NSObject *model = [self tableView:tableView modelForCellAtIndexPath:indexPath];
  if ([model isKindOfClass:[NSString class]]) {
    return NSStringFromClass([YLExampleTextCell class]);
  } else if ([model isKindOfClass:[YLExampleImagesCellModel class]]) {
    return NSStringFromClass([YLExampleImagesCell class]);
  }
  NSAssert(NO, @"No reuse identifier for model %@", model);
  return nil;
}

- (NSObject *)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
  // The model returned here must work with the cell specified above.
  return self.sectionModels[indexPath.section][indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForHeaderInSection:(NSUInteger)section {
  return NSStringFromClass([YLTableViewSectionHeaderFooterLabelView class]);
}

- (void)tableView:(UITableView *)tableView configureHeader:(YLTableViewSectionHeaderFooterView *)headerView forSection:(NSUInteger)section {
  [super tableView:tableView configureHeader:headerView forSection:section];
  YLTableViewSectionHeaderFooterLabelView *labelHeaderView = (YLTableViewSectionHeaderFooterLabelView *)headerView;
  switch ((YLExampleTableViewSection)section) {
    case YLExampleTableViewSectionText:
      labelHeaderView.text = @"Text Cells";
      break;
    case YLExampleTableViewSectionImages:
      labelHeaderView.text = @"Child View Controller Cells";
      break;
  }
}

#pragma mark YLTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.sectionModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.sectionModels[section] count];
}

#pragma mark YLTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSObject *model = [self tableView:tableView modelForCellAtIndexPath:indexPath];
  if ([model isKindOfClass:[YLExampleImagesCellModel class]]) {
    id<YLExampleTableViewDataSourceDelegate> delegate = self.delegate;
    [delegate exampleTableViewDataSource:self didSelectImagesModel:(YLExampleImagesCellModel *)model];
  }
}

@end
