//
//  SDetailViewController.m
//  SPullTransition
//
//  Created by Superman on 2018/6/5.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SDetailViewController.h"

@interface SDetailViewController ()
@property (nonatomic, strong) UIImageView* backGroundImageView;

@end

@implementation SDetailViewController
-(UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
        _backGroundImageView.image=[UIImage imageNamed:@"1"];
    }
    return _backGroundImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backGroundImageView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
