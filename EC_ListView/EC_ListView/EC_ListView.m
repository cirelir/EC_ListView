//
//  EC_ListView.m
//  EC_ListView
//
//  Created by 郭金船 on 16/8/15.
//  Copyright © 2016年 BDHOME. All rights reserved.
//

#import "EC_ListView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface EC_ListViewCell : UITableViewCell

/**
 *  listView item的图片设置
 */
@property (nonatomic, strong) UIImageView * itemIcon;

/**
 *  listView item的标题设置
 */
@property (nonatomic, strong) UILabel * itemTitle;

@end


@implementation EC_ListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.itemIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 3, self.frame.size.height - 6, self.frame.size.height - 6)];
        self.itemIcon.contentMode = UIViewContentModeScaleAspectFit;
        self.itemTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height + 25, 3, self.frame.size.width - self.frame.size.height - 25, self.frame.size.height - 6)];
        [self.contentView addSubview:self.itemIcon];
        [self.contentView addSubview:self.itemTitle];
    }
    return self;
}


@end




@interface EC_ListView()<UITableViewDelegate,UITableViewDataSource>

/**
 *  数据展示表格
 */
@property (nonatomic, retain) UITableView *listView;

/**
 *  listView显示的标题
 */
@property (nonatomic, retain) NSArray * EC_listTitles;

/**
 *  listView显示的图片
 */
@property (nonatomic, retain) NSArray * EC_listImages;

/**
 *  listview的高度
 */
@property (nonatomic, assign) CGFloat EC_height;


/**
 *  listView item的高度
 */
@property (nonatomic, assign) CGFloat EC_itemHeight;

/**
 *  listView的箭头显示方向
 */
@property (nonatomic, assign) EC_ListViewDirection EC_Direction;

@end


@implementation EC_ListView{
    CGRect arrowFrame;
}


- (instancetype)initWithSuperControl:(id)itemControl andItemTitles:(NSArray *)itemTitles andItemImages:(NSArray *)itemImages{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self != nil) {
        
        self.EC_listImages = itemImages;
        self.EC_listTitles = itemTitles;
        self.backgroundColor = [UIColor clearColor];
        self.EC_itemHeight = 45;
        
        //开启用户交互权限
        self.userInteractionEnabled = YES;
        
        /**
         *  设置listView的高度
         */
        if (self.EC_listTitles.count * self.EC_itemHeight + 20 > SCREEN_HEIGHT * 0.3){
            self.EC_height = SCREEN_HEIGHT * 0.3;
        }else{
            self.EC_height = self.EC_listTitles.count * self.EC_itemHeight + 20;
        }
        
        //如果是该控件为手势
        if ([itemControl isKindOfClass:[UIGestureRecognizer class]]) {
            UIGestureRecognizer *gesture = (UIGestureRecognizer *) itemControl;
            UIView * view = gesture.view;
            [self calculateListViewLocation:view];
            
        }else{
            UIView * view = (UIView *)itemControl;
            [self calculateListViewLocation:view];
        }
        
    }
    return  self;
}

/**
 *  通过支持alert出ListView的视图来计算出ListView的origin
 *
 *  @param view 支持alert的视图控件
 */
- (void) calculateListViewLocation:(UIView *)view{
    CGPoint rect = view.center;
    int height = [UIScreen mainScreen].bounds.size.height;
    int origin_y = rect.y + view.frame.size.height / 2;
    CGFloat location = origin_y % height;
    
    /**
     *  通过location来计算listView的frame
     *  当listview向下显示的时候超出屏幕高度的时候 就向上显示
     *  当listview向上显示的时候超出屏幕高度的时候 就向下显示
     */
    
    CGRect listViewFrame;
    
    if(location + self.EC_height < SCREEN_HEIGHT){
        /**
         *  箭头方向朝上
         */
        if (rect.x - view.frame.size.width /2 + SCREEN_WIDTH * 0.5 < SCREEN_WIDTH) {
            arrowFrame = CGRectMake(rect.x - view.frame.size.width /2 + 10, origin_y, 20, 20);
            listViewFrame = CGRectMake(rect.x - view.frame.size.width /2, origin_y + 20, SCREEN_WIDTH * 0.5, self.EC_height - 20);
            self.EC_Direction = EC_ListViewDirectionLeftTop;
        }else{
            arrowFrame = CGRectMake(rect.x + view.frame.size.width /2 - 30, origin_y, 20, 20);
            listViewFrame = CGRectMake(rect.x + view.frame.size.width /2 - SCREEN_WIDTH * 0.5, origin_y + 20, SCREEN_WIDTH * 0.5, self.EC_height - 20);
            self.EC_Direction = EC_ListViewDirectionRightTop;
        }
    }else {     //箭头方向朝下
        if (rect.x - view.frame.size.width /2 + SCREEN_WIDTH * 0.5 < SCREEN_WIDTH) {
            arrowFrame = CGRectMake(rect.x - view.frame.size.width /2 + 10, rect.y - view.frame.size.height/2 - 20, 20, 20);
            listViewFrame = CGRectMake(rect.x - view.frame.size.width /2, rect.y - view.frame.size.height/2 - self.EC_height, SCREEN_WIDTH * 0.5, self.EC_height - 20);
            self.EC_Direction = EC_ListViewDirectionLeftBottom;
        }else{
            arrowFrame = CGRectMake(rect.x + view.frame.size.width /2 - 30, rect.y - view.frame.size.height/2 - 20, 20, 20);
            listViewFrame = CGRectMake(rect.x + view.frame.size.width /2 - SCREEN_WIDTH * 0.5, rect.y - view.frame.size.height/2 - self.EC_height, SCREEN_WIDTH * 0.5, self.EC_height - 20);
            self.EC_Direction = EC_ListViewDirectionRightBottom;
        }
    }
    
    [self setNeedsDisplay];
    [self setTableViewWithFame:listViewFrame];
}



- (void)setTableViewWithFame:(CGRect) frame{
    _listView = [[UITableView alloc]initWithFrame: frame style: UITableViewStylePlain];
    _listView.layer.borderWidth = 0.5f;
    _listView.layer.borderColor = [UIColor grayColor].CGColor;
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.bounces = NO;
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    if ([_listView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_listView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_listView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_listView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self addSubview:_listView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.EC_listTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.EC_itemHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    
    if (self.EC_listImages.count > 0) {
        EC_ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[EC_ListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundColor = self.EC_BackGroundColor ? self.EC_BackGroundColor : [UIColor whiteColor];
        cell.itemIcon.image = [UIImage imageNamed:self.EC_listImages[indexPath.row]];
        cell.itemTitle.text = self.EC_listTitles[indexPath.row];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundColor = self.EC_BackGroundColor ? self.EC_BackGroundColor : [UIColor whiteColor];
        cell.textLabel.text = self.EC_listTitles[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber * index = @(indexPath.row);
    if (self.itemOnclick) {
        self.itemOnclick(index);
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


/**
 *  绘制指示三角形；
 *
 *  @param rect
 */
- (void) drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    if (self.EC_Direction == EC_ListViewDirectionLeftTop || self.EC_Direction == EC_ListViewDirectionRightTop) {
        [[UIColor grayColor] setFill];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, arrowFrame.size.width/2 + arrowFrame.origin.x, arrowFrame.origin.y + 5);//设置起点
        CGContextAddLineToPoint(context, arrowFrame.origin.x + arrowFrame.size.width, arrowFrame.origin.y + arrowFrame.size.height);
        CGContextAddLineToPoint(context, arrowFrame.origin.x, arrowFrame.origin.y + arrowFrame.size.height);
        CGContextClosePath(context);
        
        [[UIColor grayColor] setStroke];
        
        CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
    }else{
        [[UIColor grayColor] setFill];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, arrowFrame.origin.x, arrowFrame.origin.y);//设置起点
        CGContextAddLineToPoint(context, arrowFrame.origin.x + arrowFrame.size.width, arrowFrame.origin.y);
        CGContextAddLineToPoint(context, arrowFrame.origin.x + arrowFrame.size.width / 2, arrowFrame.origin.y + arrowFrame.size.height - 5);
        CGContextClosePath(context);
        
        [[UIColor grayColor] setStroke];
        
        CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
        
    }
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}


















@end
