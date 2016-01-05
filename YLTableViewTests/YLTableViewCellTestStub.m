//
//  YLTableViewCellConformsToProtocol.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewCellTestStub.h"

const CGFloat kYLTableViewCellStubHeight = 100.0;

@implementation YLTableViewCellTestStub

-(void)setModel:(id)model { }

+ (CGFloat)estimatedRowHeight {
  return kYLTableViewCellStubHeight;
}

@end
