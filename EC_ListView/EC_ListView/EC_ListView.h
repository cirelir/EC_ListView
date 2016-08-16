//
//  EC_ListView.h
//  EC_ListView
//
//  Created by 郭金船 on 16/8/15.
//  Copyright © 2016年 BDHOME. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EC_ListViewDirectionLeftTop,        //箭头显示在左上角
    EC_ListViewDirectionRightTop,       //箭头显示在右上角
    EC_ListViewDirectionLeftBottom,     //箭头显示在左下角
    EC_ListViewDirectionRightBottom,    //箭头显示在右下角
} EC_ListViewDirection;

@interface EC_ListView : UIView

/**
 *  listView的背景颜色
 */
@property (nonatomic, retain) UIColor * EC_BackGroundColor;

/**
 *  listview点击回调block
 */
@property (nonatomic, copy)void (^itemOnclick)(id);


-(instancetype) initWithSuperControl:(id)itemControl  andItemTitles:(NSArray *)itemTitles   andItemImages:(NSArray *)itemImages;


@end
