//
//  NextViewController.m
//  EC_ListView
//
//  Created by 郭金船 on 16/8/16.
//  Copyright © 2016年 BDHOME. All rights reserved.
//

#import "NextViewController.h"
#import "EC_ListView/EC_ListView.h"

@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, retain)NSMutableArray * dataSrouce;

@end

@implementation NextViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self createData];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.view addSubview:self.tableview];
}


- (void)createData{
    self.dataSrouce = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 20; i++) {
        NSString *string = [NSString stringWithFormat:@"测试数据%@", @(i+1)];
        [self.dataSrouce addObject:string];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSrouce.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSrouce[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = @[@"QQ",@"微信",@"微博"];
    NSArray * image = @[@"Image", @"weixin", @"xinlang"];
    
    UITableViewCell * cell = [self.tableview cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",@(cell.frame.origin.y));
    
    EC_ListView * listView = [[EC_ListView alloc]initWithSuperControl:cell andItemTitles:array andItemImages:image];
    listView.EC_BackGroundColor = [UIColor grayColor];
    listView.itemOnclick = ^(id index){
        NSLog(@"%@",index);
    };
    [self.view addSubview:listView];
}

@end
