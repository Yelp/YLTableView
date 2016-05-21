
//  YLTableViewDataSourceTestStub.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewDataSourceTestStub.h"
#import "YLTableViewDataSourceSubclass.h"

const CGFloat kYLTableViewDataSourceTestStubOverriddenHeight = 200.0;


@implementation YLTableViewCellModelTestStub

+ (instancetype)modelWithReuseIdentifier:(NSString *)reuseIdentifier estimatedHeight:(CGFloat)estimatedHeight {
  YLTableViewCellModelTestStub *model = [[self alloc] init];
  model.reuseIdentifier = reuseIdentifier;
  model.estimatedHeight = estimatedHeight;
  return model;
}

@end


@implementation YLTableViewDataSourceTestStub

- (id)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
  return self.models[indexPath];
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return self.models[indexPath].reuseIdentifier;
}

@end
