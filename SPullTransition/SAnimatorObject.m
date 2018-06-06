//
//  SAnimatorObject.m
//  SPullTransition
//
//  Created by Superman on 2018/6/5.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SAnimatorObject.h"

#import "SMasterViewController.h"
#import "SDetailViewController.h"


@implementation SAnimatorObject

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    SMasterViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    SDetailViewController *toVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView=[transitionContext containerView];
    NSTimeInterval duration=[self transitionDuration:transitionContext];
    
    UIView *imageSnapshot=[[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame=fromVC.view.frame;
    toVC.view.frame=[transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha=0;
    [containerView addSubview:toVC.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha=1.0;
        imageSnapshot.alpha=0.0;
        imageSnapshot.transform = CGAffineTransformTranslate(imageSnapshot.transform, 0, -100);
    }completion:^(BOOL finished) {
        [imageSnapshot removeFromSuperview];
        fromVC.view.transform=CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}








- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
@end
