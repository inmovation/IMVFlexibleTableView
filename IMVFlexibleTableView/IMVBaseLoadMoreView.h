//
//  BaseLoadMoreView.h
//  TLPullRefreshViewDemo
//
//  Created by Creolophus on 4/16/15.
//  Copyright (c) 2015 Creolophus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LoadStateNormal = 0,
    LoadStateLoading,
    LoadStateReachEnd
} LoadState;

@interface IMVBaseLoadMoreView : UIView

@property (strong, nonatomic) UIColor *tintColor;
@property (assign, nonatomic) LoadState loadState;

@end
