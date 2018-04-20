//
//  RightTableView.h
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewHeader.h"

@class RightTableView;
@protocol RightTableViewDelegate <NSObject>

@optional
- (void)rightTableView:(RightTableView *)rightTableView selectIndexPath:(NSIndexPath *)indexPath;

@end

@interface RightTableView : UITableView

@property (nonatomic,assign) BOOL isNotification;
@property (nonatomic,retain) NSNotification *notification;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, weak) id <RightTableViewDelegate> rightTableViewDelegate;

@end
