//
//  ViewController.m
//  EC_ListView
//
//  Created by 郭金船 on 16/8/15.
//  Copyright © 2016年 BDHOME. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, 40, 30)];
    [button setTitle:@"点我试试" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width -50, 40, 40, 30)];
    [button1 setTitle:@"点我试试" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 50, 40, 30)];
    [button2 setTitle:@"点我试试" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];
    
    
    UIButton * button3= [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width -50, self.view.frame.size.height - 50, 40, 30)];
    [button3 setTitle:@"点我试试" forState:UIControlStateNormal];
    [button3 setBackgroundColor:[UIColor blueColor]];
    [button3 addTarget:self action:@selector(alertListView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button3];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
