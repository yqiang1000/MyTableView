//
//  Utils.m
//  Huafeng
//
//  Created by yeqiang on 2018/3/29.
//  Copyright © 2018年 yeqiang. All rights reserved.
//

#import "Utils.h"

@implementation Utils

// 获取顶层控制器
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [Utils _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [Utils _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [Utils _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [Utils _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIView *)getLineView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor darkGrayColor];
    
    return view;
}


+ (CAShapeLayer *)drawContentFrame:(CGRect)frame corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}



@end
