//
//  LeftTableView.h
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewHeader.h"

@class LeftTableView;
@protocol LeftTableViewDelegate <NSObject>

@optional
- (void)leftTableView:(LeftTableView *)leftTableView selectIndexPath:(NSIndexPath *)indexPath;

@end

@interface LeftTableView : UITableView

@property (nonatomic,assign) BOOL isNotification;
@property (nonatomic,retain) NSNotification *notification;

@property (nonatomic, weak) id <LeftTableViewDelegate> leftTableViewDelegate;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray *arrData;

@end
