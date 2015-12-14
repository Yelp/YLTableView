//
//  YLTableViewBaseTestCase.h
//  YLTableView
//
//  Created by Ushhud Khalid on 12/9/15.
//  Copyright © 2015 Yelp. All rights reserved.
//

#import <XCTest/XCTestCase.h>

//! New tests should subclass from this class as it contains contains all common test methods/properties.
@interface YLTableViewBaseTestCase : XCTestCase

//! Redeclaring to add the compiler warning if super is missing
+ (void)setUp NS_REQUIRES_SUPER;
+ (void)tearDown NS_REQUIRES_SUPER;
- (void)setUp NS_REQUIRES_SUPER;
- (void)tearDown NS_REQUIRES_SUPER;

@end
