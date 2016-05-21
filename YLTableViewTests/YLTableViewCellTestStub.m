//
//  YLTableViewCellTestStub.m
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import "YLTableViewCellTestStub.h"
#import "YLTableViewDataSourceTestStub.h"

const CGFloat kYLTableViewCellStubHeight = 100.0;


@implementation YLTableViewCellTestStub

-(void)setModel:(id)model { }

+ (CGFloat)estimatedRowHeight {
  return kYLTableViewCellStubHeight;
}

@end


@implementation YLTableViewCellTestStubCustomEstimatedHeight

- (void)setModel:(id)model { }

+ (CGFloat)estimatedRowHeight {
  return kYLTableViewCellStubHeight;
}

+ (CGFloat)estimatedRowHeightForModel:(id)model {
  return [(YLTableViewCellModelTestStub *)model estimatedHeight];
}

@end
