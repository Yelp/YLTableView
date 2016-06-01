
//  YLTableViewDataSourceTestStub.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewDataSourceTestStub.h"

#import "YLTableViewDataSourceSubclass.h"

const CGFloat kYLTableViewDataSourceTestStubOverriddenHeight = 200.0;

@implementation YLTableViewDataSourceTestStub

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return self.reuseIdentifiers[indexPath];
}

- (id)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
  return [[NSObject alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedRowHeightForModel:(id)model forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.shouldOverrideEstimatedRowHeight) {
    return kYLTableViewDataSourceTestStubOverriddenHeight;
  } else {
    return [super tableView:tableView estimatedRowHeightForModel:model forRowAtIndexPath:indexPath];
  }
}

@end
