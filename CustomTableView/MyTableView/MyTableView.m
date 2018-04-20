//
//  MyTableView.m
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "MyTableView.h"
#import "LeftTableView.h"
#import "RightTableView.h"
#import "TopScrollView.h"

@interface MyTableView () <RightTableViewDelegate, LeftTableViewDelegate, TopScrollViewDelegate>

@property (nonatomic, strong) TopScrollView *scrollViewTop;
@property (nonatomic, strong) LeftTableView *tableViewLeft;
@property (nonatomic, strong) RightTableView *tableViewRight;

@property (nonatomic, strong) NSMutableArray *arrLeftTitle;
@property (nonatomic, strong) NSMutableArray *arrTopTitle;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) UILabel *labTopLeft;

@end

@implementation MyTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    _cellHeight = kCELL_HEIGHT;
    _cellWidth = kCELL_WIDTH;
    [self setUI];
    self.tableViewLeft.arrData = self.arrLeftTitle;
    self.scrollViewTop.arrData = self.arrTopTitle;
    self.tableViewRight.arrData = self.arrData;
    self.labTopLeft.text = @"产品类型";
    self.layer.borderColor = COLOR_LINE.CGColor;
    self.layer.borderWidth = 0.5;
    
}

- (void)setUI {
    
    [self addSubview:self.labTopLeft];
    [self addSubview:self.scrollViewTop];
    [self addSubview:self.tableViewLeft];
    [self addSubview:self.tableViewRight];
    
    [self.scrollViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(self.cellWidth);
        make.right.equalTo(self);
        make.height.equalTo(@(self.cellHeight));
    }];
    
    [self.tableViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollViewTop.mas_bottom);
        make.left.equalTo(self);
        make.width.equalTo(@(self.cellWidth));
        make.bottom.equalTo(self);
    }];
    
    [self.tableViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollViewTop.mas_bottom);
        make.left.equalTo(self.scrollViewTop);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.labTopLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.right.equalTo(self.tableViewRight.mas_left);
        make.bottom.equalTo(self.tableViewLeft.mas_top);
    }];
    
    UIView *lineViewY = [Utils getLineView];
    [self addSubview:lineViewY];
    [lineViewY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tableViewLeft);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@0.5);
    }];
}

#pragma mark - TopScrollViewDelegate

- (void)topScrollView:(TopScrollView *)topScrollView selectIndex:(NSInteger)index {
    if (_myViewDelegate && [_myViewDelegate respondsToSelector:@selector(myTableView:selectTopIndex:)]) {
        [_myViewDelegate myTableView:self selectTopIndex:index];
    }
}

#pragma mark - LeftTableViewDelegate

- (void)leftTableView:(LeftTableView *)leftTableView selectIndexPath:(NSIndexPath *)indexPath {
    if (_myViewDelegate && [_myViewDelegate respondsToSelector:@selector(myTableView:selectTitleIndexPath:)]) {
        [_myViewDelegate myTableView:self selectTitleIndexPath:indexPath];
    }
}

#pragma mark - RightTableViewDelegate

- (void)rightTableView:(RightTableView *)rightTableView selectIndexPath:(NSIndexPath *)indexPath {
    if (_myViewDelegate && [_myViewDelegate respondsToSelector:@selector(myTableView:selectItemIndexPath:)]) {
        [_myViewDelegate myTableView:self selectItemIndexPath:indexPath];
    }
}

#pragma mark - setter getter

- (LeftTableView *)tableViewLeft {
    if (!_tableViewLeft) {
        _tableViewLeft = [[LeftTableView alloc] initWithFrame:CGRectZero];
        _tableViewLeft.cellWidth = _cellWidth;
        _tableViewLeft.cellHeight = _cellHeight;
    }
    return _tableViewLeft;
}

- (RightTableView *)tableViewRight {
    if (!_tableViewRight) {
        _tableViewRight = [[RightTableView alloc] initWithFrame:CGRectZero];
        _tableViewRight.cellWidth = _cellWidth;
        _tableViewRight.cellHeight = _cellHeight;
        _tableViewRight.rightTableViewDelegate = self;
    }
    return _tableViewRight;
}

- (TopScrollView *)scrollViewTop {
    if (!_scrollViewTop) {
        _scrollViewTop = [[TopScrollView alloc] init];
        _scrollViewTop.contentSize = CGSizeZero;
        _scrollViewTop.topScrollViewDelegate = self;
    }
    return _scrollViewTop;
}

- (NSMutableArray *)arrLeftTitle {
    if (!_arrLeftTitle) {
        _arrLeftTitle = [NSMutableArray new];
        for (int i = 0; i < 50; i++) {
            [_arrLeftTitle addObject:[NSString stringWithFormat:@"行标题%d",i]];
        }
    }
    return _arrLeftTitle;
}

- (NSMutableArray *)arrTopTitle {
    if (!_arrTopTitle) {
        _arrTopTitle = [NSMutableArray new];
        for (int i = 0; i < 20; i++) {
            [_arrTopTitle addObject:[NSString stringWithFormat:@"列标题%d",i]];
        }
    }
    return _arrTopTitle;
}

- (NSMutableArray *)arrData {
    if (!_arrData) {
        _arrData = [NSMutableArray new];
        for (int i = 0; i < self.arrLeftTitle.count; i++) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int j = 0; j < self.arrTopTitle.count; j++) {
                [arr addObject:[NSString stringWithFormat:@"%d行,%d列", i, j]];
            }
            [_arrData addObject:arr];
        }
    }
    return _arrData;
}

- (UILabel *)labTopLeft {
    if (!_labTopLeft) {
        _labTopLeft = [UILabel new];
        _labTopLeft.font = FONT_F12;
        _labTopLeft.textColor = COLOR_B1;
        _labTopLeft.textAlignment = NSTextAlignmentCenter;
        UIView *line = [Utils getLineView];
        [_labTopLeft addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_labTopLeft);
            make.height.equalTo(@0.5);
        }];
    }
    return _labTopLeft;
}

@end
