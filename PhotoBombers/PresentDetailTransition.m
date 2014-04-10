//
//  PresentDetailTransition.m
//  PhotoBombers
//
//  Created by Matthew Voracek on 4/9/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "PresentDetailTransition.h"

@implementation PresentDetailTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    detail.view.alpha = 0.0;
    CGRect frame = containerView.bounds;
    frame.origin.y += 20;
    frame.size.height -= 20;
    detail.view.frame = frame;
    [containerView addSubview:detail.view];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
