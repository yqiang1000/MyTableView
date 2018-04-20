//
//  RightTableViewCell.h
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopScrollView.h"
#import "MyTableViewHeader.h"

@class RightTableViewCell;
@protocol RightTableViewCellDelegate <NSObject>

@optional
- (void)rightTableViewCell:(RightTableViewCell *)rightTableViewCell selectIndex:(NSInteger)index;
@end


@interface RightTableViewCell : UITableViewCell <TopScrollViewDelegate>

@property (nonatomic, strong) TopScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, weak) id <RightTableViewCellDelegate> rightTableViewCellDelegate;

- (void)loadDataWith:(NSMutableArray *)arrData;

@end
