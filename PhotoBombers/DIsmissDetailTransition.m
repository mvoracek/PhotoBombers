//
//  DIsmissDetailTransition.m
//  PhotoBombers
//
//  Created by Matthew Voracek on 4/9/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "DismissDetailTransition.h"

@implementation DismissDetailTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}



@end
