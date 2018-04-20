//
//  MyTableView.h
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewHeader.h"

@class MyTableView;
@protocol MyTableViewDelegate <NSObject>

@optional
- (void)myTableView:(MyTableView *)myTableView selectItemIndexPath:(NSIndexPath *)indexPath;

- (void)myTableView:(MyTableView *)myTableView selectTitleIndexPath:(NSIndexPath *)indexPath;

- (void)myTableView:(MyTableView *)myTableView selectTopIndex:(NSInteger)index;

@end

@interface MyTableView : UIView

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, weak) id <MyTableViewDelegate> myViewDelegate;

@end
