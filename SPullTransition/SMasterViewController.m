//
//  SMasterViewController.m
//  SPullTransition
//
//  Created by Superman on 2018/6/5.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SMasterViewController.h"
#import "SDetailViewController.h"
#import "SAnimatorObject.h"


@interface SMasterViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView* backGroundImageView;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePushTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end

@implementation SMasterViewController

-(UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
        _backGroundImageView.image=[UIImage imageNamed:@"2.jpg"];
    }
    return _backGroundImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backGroundImageView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}
- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate=self;
    self.panRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanRecognizer:)];
    [self.view addGestureRecognizer:self.panRecognizer];
}
#pragma mark UINavigationControllerDelegate
//自定义一个不带用户交互的转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (fromVC==self && [toVC isKindOfClass:[SDetailViewController class]]) {
        return [[SAnimatorObject alloc]init];
    }else{
        return nil;
    }
}
//可以为这个动画添加用户交互。   需要创建一个转场动画对象，来作为第一个方法的返回值。如果给第一个方法返回nil，则UIKit会使用默认的转场动画效果。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[SAnimatorObject class]]) {
        return self.interactivePushTransition;
    }else{
        return nil;
    }
}
- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer {
    static CGFloat startLocationY = 0;
    CGPoint location =[recognizer locationInView:self.view];
    CGFloat progress = (location.y - startLocationY) / [UIScreen mainScreen].bounds.size.width;
    progress = -progress;
    
    progress =MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocationY = location.y;
        self.interactivePushTransition=[[UIPercentDrivenInteractiveTransition alloc]init];
        SDetailViewController *vc=[[SDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (recognizer.state ==UIGestureRecognizerStateChanged ){
        CGFloat offset = location.y - startLocationY;
        NSLog(@"progress:   %.2f", offset);
        [self.interactivePushTransition updateInteractiveTransition:progress];
    }else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.3) {
            self.interactivePushTransition.completionSpeed = 0.4;
            [self.interactivePushTransition finishInteractiveTransition];
        }
        else {
            self.interactivePushTransition.completionSpeed = 0.3;
            [self.interactivePushTransition cancelInteractiveTransition];
        }
        self.interactivePushTransition = nil;
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
