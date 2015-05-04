//
//  SubPullRefreshTableView.m
//  TLPullRefreshViewDemo
//
//  Created by Creolophus on 4/30/15.
//  Copyright (c) 2015 Creolophus. All rights reserved.
//

#import "SubPullRefreshTableView.h"
#import "CustomTopRefreshView.h"
#import "CustomLoadMoreView.h"

@interface SubPullRefreshTableView ()

@end

@implementation SubPullRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style pullRefreshType:(PullRefreshType)prType{
    self = [super initWithFrame:frame style:style pullRefreshType:prType];
    if (self) {
        [self customRefreshView];
        [self customLoadView];
    }
    return self;
}

- (void)customRefreshView{
    self.topRefreshView = [CustomTopRefreshView new];
    [super customRefreshView];
}

- (void)customLoadView{
    self.loadMoreView = [CustomLoadMoreView new];
    [super customLoadView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
