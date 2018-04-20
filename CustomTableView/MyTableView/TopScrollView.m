//
//  TopScrollView.m
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "TopScrollView.h"

@interface TopScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrBtn;

@end

@implementation TopScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellHeight = kCELL_HEIGHT;
        _cellWidth = kCELL_WIDTH;
        self.delegate = self;
        self.backgroundColor = COLOR_B4;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:NOTIF_CELL_SCROLL object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setArrData:(NSMutableArray *)arrData {
    if (_arrData.count != arrData.count) {
        [self.arrBtn removeAllObjects];
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
        _arrData = arrData;
        [self setUI];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0; i < self.arrBtn.count; i++) {
                [self.arrBtn[i] setTitle:arrData[i] forState:UIControlStateNormal];
            }
        });
    }
}

- (void)setUI {
    UIView *lastView = nil;
    for (int i = 0; i < self.arrData.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        
        btn.titleLabel.font = FONT_F12;
        [btn setTitleColor:COLOR_B1 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.tag = 100+i;
        [btn setTitle:_arrData[i] forState:UIControlStateNormal];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            if (lastView) {
                make.left.equalTo(lastView.mas_right);
            } else {
                make.left.equalTo(self);
            }
            make.width.equalTo(@(self.cellWidth));
            make.height.equalTo(@(self.cellHeight));
        }];
        if (i == self.arrData.count-1) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self);
            }];
        }
        lastView = btn;
        [self.arrBtn addObject:btn];
        if (i < self.arrData.count-1) {
            UIView *lineView = [Utils getLineView];
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(btn);
                make.right.equalTo(btn);
                make.width.equalTo(@0.5);
            }];
        }
    }
    
    UIView *lineView = [Utils getLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(self.cellHeight-0.5);
        make.height.equalTo(@0.5);
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isNotification = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_CELL_SCROLL object:self userInfo:@{@"x":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 避开自己发的通知，只有手指拨动才会是自己的滚动
    if (!_isNotification) {
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_CELL_SCROLL object:self userInfo:@{@"x":@(scrollView.contentOffset.x)}];
    }
    _isNotification = NO;
}


-(void)scrollMove:(NSNotification*)notification{
    NSDictionary *xn = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [xn[@"x"] floatValue];
    if (obj!=self) {
        _isNotification = YES;
        [self setContentOffset:CGPointMake(x, 0) animated:NO];
    }else{
        _isNotification = NO;
    }
    obj = nil;
}

#pragma mark - event

- (void)btnClick:(UIButton *)sender {
    if (_topScrollViewDelegate && [_topScrollViewDelegate respondsToSelector:@selector(topScrollView:selectIndex:)]) {
        NSInteger index = sender.tag - 100;
        [_topScrollViewDelegate topScrollView:self selectIndex:index];
    }
}

#pragma mark - setter getter

- (NSMutableArray *)arrBtn {
    if (!_arrBtn) {
        _arrBtn = [NSMutableArray new];
    }
    return _arrBtn;
}

@end
