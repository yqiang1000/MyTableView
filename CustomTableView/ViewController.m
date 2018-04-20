//
//  ViewController.m
//  CustomTableView
//
//  Created by yeqiang on 2018/4/19.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "ViewController.h"
#import "MyTableView.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) MyTableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(20);
        make.right.bottom.equalTo(self.view).offset(-20);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MyTableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[MyTableView alloc] init];
        _myTableView.backgroundColor = [UIColor redColor];
    }
    return _myTableView;
}


@end
