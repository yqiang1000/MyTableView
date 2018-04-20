//
//  LeftTableView.m
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "LeftTableView.h"

@interface LeftTableView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation LeftTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        _cellHeight = kCELL_HEIGHT;
        _cellWidth = kCELL_WIDTH;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:NOTIF_TABLE_SCROLL object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"leftCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        UIView *lineViewX = [Utils getLineView];
        [cell.contentView addSubview:lineViewX];
        
        [lineViewX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell.contentView);
            make.height.equalTo(@0.5);
        }];
        
        cell.textLabel.textColor = COLOR_C1;
        cell.textLabel.font = FONT_F12;
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.arrData[indexPath.row]];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR_C1 range:NSMakeRange(0,str.length)];
    //加下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    cell.textLabel.attributedText = str;
    return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isNotification = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_TABLE_SCROLL object:self userInfo:@{@"y":@(scrollView.contentOffset.y)}];
    }
    _isNotification = NO;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 避开自己发的通知，只有手指拨动才会是自己的滚动
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_TABLE_SCROLL object:self userInfo:@{@"y":@(scrollView.contentOffset.y)}];
    }
    _isNotification = NO;
}

-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *xn = notification.userInfo;
    NSObject *obj = notification.object;
    float y = [xn[@"y"] floatValue];
    if (obj!=self) {
        _isNotification = YES;
        [self setContentOffset:CGPointMake(0, y) animated:NO];
    }else{
        _isNotification = NO;
    }
    obj = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftTableViewDelegate && [_leftTableViewDelegate respondsToSelector:@selector(leftTableView:selectIndexPath:)]) {
        [_leftTableViewDelegate leftTableView:self selectIndexPath:indexPath];
    }
}

@end
