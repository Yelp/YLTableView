//
//  YLTableViewPrivate.h
//  YLTableView
//
//  Created by Mason Glidden on 6/3/15.
//  Copyright (c) 2015 Yelp. All rights reserved.
//

#import "YLTableView.h"

@interface YLTableView ()

//! Returns a cached cell for this reuse identifier. The cell should only be used for sizing purposes, not for display.
- (YLTableViewCell *)sizingCellForReuseIdentifier:(NSString *)reuseIdentifier;

//! Returns a cached section header/footer view for this reuse identifier. The view should only be used for sizing purposes, not for display.
- (YLTableViewSectionHeaderFooterView *)sizingHeaderFooterViewForReuseIdentifier:(NSString *)reuseIdentifier;

@end
