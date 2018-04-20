//
//  RightTableViewCell.m
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR_B4;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.contentView);
    }];
    
    UIView *lineView = [Utils getLineView];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - TopScrollViewDelegate

- (void)topScrollView:(TopScrollView *)topScrollView selectIndex:(NSInteger)index {
    if (_rightTableViewCellDelegate && [_rightTableViewCellDelegate respondsToSelector:@selector(rightTableViewCell:selectIndex:)]) {
        [_rightTableViewCellDelegate rightTableViewCell:self selectIndex:index];
    }
}

#pragma mark - public

- (void)loadDataWith:(NSMutableArray *)arrData {
    _arrData = arrData;
    self.scrollView.arrData = _arrData;
}

#pragma mark - setter getter

- (TopScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TopScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.contentSize = CGSizeZero;
        _scrollView.topScrollViewDelegate = self;
    }
    return _scrollView;
}

@end
