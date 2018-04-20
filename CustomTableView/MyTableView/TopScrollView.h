//
//  TopScrollView.h
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewHeader.h"

@class TopScrollView;
@protocol TopScrollViewDelegate <NSObject>
- (void)topScrollView:(TopScrollView *)topScrollView selectIndex:(NSInteger)index;

@end

@interface TopScrollView : UIScrollView

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic,assign) BOOL isNotification;
@property (nonatomic,retain) NSNotification *notification;

@property (nonatomic, weak) id <TopScrollViewDelegate> topScrollViewDelegate;

@end
