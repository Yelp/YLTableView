
//  YLTableViewDataSourceTestStub.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewDataSourceTestStub.h"

const CGFloat kYLTableViewDataSourceTestStubOverriddenHeight = 200.0;

@implementation YLTableViewDataSourceTestStub

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return NSStringFromClass([self.tableViewCells[indexPath] class]);
}

@end
