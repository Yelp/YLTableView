
//  YLTableViewDataSourceTestStub.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <YLTableView/YLTableViewDataSourceSubclass.h>

#import "YLTableViewDataSourceTestStub.h"

const CGFloat kYLTableViewDataSourceTestStubOverriddenHeight = 200.0;

@implementation YLTableViewDataSourceTestStub

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return self.reuseIdentifiers[indexPath];
}

- (id)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
  return [[NSObject alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath withModel:(id)model {
  if (self.shouldOverrideEstimatedRowHeight) {
    return kYLTableViewDataSourceTestStubOverriddenHeight;
  } else {
    return [super tableView:tableView estimatedHeightForRowAtIndexPath:indexPath withModel:model];
  }
}

@end
