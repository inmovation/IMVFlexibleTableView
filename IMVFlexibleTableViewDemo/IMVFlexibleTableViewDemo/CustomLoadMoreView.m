//
//  CustomLoadMoreView.m
//  TLPullRefreshViewDemo
//
//  Created by Creolophus on 4/30/15.
//  Copyright (c) 2015 Creolophus. All rights reserved.
//

#import "CustomLoadMoreView.h"

@interface CustomLoadMoreView ()
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) CAShapeLayer *ovalShapeLayer;
@end

@implementation CustomLoadMoreView

- (void)setup{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    _label.font = [UIFont systemFontOfSize:14.0];
    _label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
    _ovalShapeLayer = [[CAShapeLayer alloc] init];
    _ovalShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    _ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _ovalShapeLayer.lineWidth = 2.0;
    _ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width/2 - 10, self.frame.size.height/2 - 10, 20, 20)].CGPath;

    [self.layer addSublayer:_ovalShapeLayer];
}

- (void)setLoadState:(LoadState)loadState{
    [super setLoadState:loadState];
    switch (loadState) {
        case LoadStateNormal:{
            _label.hidden = YES;
//            [_ovalShapeLayer addAnimation:[self addRotateAnimation] forKey:nil];
            
            break;
        }
        case LoadStateLoading:{
            _ovalShapeLayer.opacity = 1.0f;
            [_ovalShapeLayer addAnimation:[self addRotateAnimation] forKey:nil];
            _label.hidden = YES;

            break;
        }
        case LoadStateReachEnd:{
            
            _ovalShapeLayer.opacity = 0.f;
            [_ovalShapeLayer removeAllAnimations];
            _label.hidden = NO;
            _label.text = @"没有更多";
            break;
        }
            
        default:
            break;
    }

}

- (CAAnimation *)addRotateAnimation{
    CABasicAnimation *a1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    a1.fromValue = @(-.5);
    a1.toValue = @(1);
    CABasicAnimation *a2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    a2.fromValue = @(0);
    a2.toValue = @(1);
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.animations = @[a1, a2];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.repeatCount = INFINITY;
    group.duration = 1;
    return group;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
