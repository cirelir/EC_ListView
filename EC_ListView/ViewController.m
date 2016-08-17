//
//  ViewController.m
//  EC_ListView
//
//  Created by 郭金船 on 16/8/15.
//  Copyright © 2016年 BDHOME. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"popover视图弹窗";
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 60, 30)];
    [button setTitle:@"点我试试" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width -70, 40, 60, 30)];
    [button1 setTitle:@"点我试试" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:12];
    [button1 setBackgroundColor:[UIColor purpleColor]];
    [button1 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 100, 60, 30)];
    [button2 setTitle:@"点我试试" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [button2 setBackgroundColor:[UIColor purpleColor]];
    [button2 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];
    
    
    UIButton * button3= [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - 100, 60, 30)];
    [button3 setTitle:@"点我试试" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:12];
    [button3 setBackgroundColor:[UIColor purpleColor]];
    [button3 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button3];
    
    
    UIButton * button4 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30, self.view.frame.size.height/2 - 15, 60, 30)];
    [button4 setTitle:@"点我试试" forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize:12];
    [button4 setBackgroundColor:[UIColor purpleColor]];
    [button4 addTarget:self action:@selector(nextController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button4];
    
}

- (void) alertListView: (UIButton *) sender{
    
    NSArray * array = @[@"QQ",@"微信",@"微博"];
    NSArray * image = @[@"Image", @"weixin", @"xinlang"];
    
    EC_ListView * listView = [[EC_ListView alloc]initWithSuperControl:sender andItemTitles:array andItemImages:image];
    listView.EC_BackGroundColor = [UIColor grayColor];
    listView.itemOnclick = ^(id index){
        NSLog(@"%@",index);
    };
    [self.view addSubview:listView];
}


-(void) nextController:(id) sender{
    NextViewController * next = [[NextViewController alloc]init];
    
    [self.navigationController pushViewController:next animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
