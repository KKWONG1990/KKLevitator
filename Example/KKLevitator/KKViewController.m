//
//  KKViewController.m
//  KKLevitator
//
//  Created by kkwong90@163.com on 01/28/2022.
//  Copyright (c) 2022 kkwong90@163.com. All rights reserved.
//

#import "KKViewController.h"
#import <KKLevitator.h>
#import <KKServerLevitateView.h>
@interface KKViewController ()<KKServerLevitateViewDelegate>
@property (nonatomic, strong) KKLevitator * redCircleLevitator;
@property (nonatomic, strong) KKLevitator * serverLevitator;
@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self showInView];
    [self showInWindow];
}

- (void)showInView {
    UIView * redCircleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    redCircleView.layer.cornerRadius = 25;
    redCircleView.backgroundColor = UIColor.redColor;
    //KKLevitator必须被强应用，否则出了作用域就被释放了
    self.redCircleLevitator = [[KKLevitator alloc] initWithLevitateView:redCircleView];
    self.redCircleLevitator.point = CGPointMake(15, 400);
    [self.redCircleLevitator showInContainer:self.view];
}

- (void)showInWindow {
    KKServerLevitateView * serverView = [[KKServerLevitateView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    serverView.infoLabel.text = @"测试服1 v1.0";
    serverView.servers = @[@"测试服 - 192.168.1.1", @"正式服 - 192.168.1.110"];
    serverView.delegate = self;
    serverView.layer.cornerRadius = 10;
    serverView.backgroundColor = UIColor.brownColor;
    //KKLevitator必须被强应用，否则出了作用域就被释放了
    self.serverLevitator = [[KKLevitator alloc] initWithLevitateView:serverView];
    self.serverLevitator.canMove = YES;
    [self.serverLevitator show];
}

- (void)serverLevitateView:(KKServerLevitateView *)serverLevitateView didSwitchServerWithIdx:(NSInteger)idx title:(NSString *)title {
    [serverLevitateView showRestartAlert];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
