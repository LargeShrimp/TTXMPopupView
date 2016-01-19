//
//  TTXMPopupWindow.m
//  TTXMPopupView
//
//  Created by taitanxiami on 16/1/19.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "TTXMPopupWindow.h"

@implementation TTXMPopupWindow

/**
 *  init
 *
 *  @return self
 */
-(instancetype)init {
    if(self = [super init]) {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.userInteractionEnabled  = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [self.attachView addGestureRecognizer:tapGesture];
    }
    return self;
}
/**
 *  获取window
 *
 *  @return window
 */
+ (instancetype)shareWindow {
    
    static TTXMPopupWindow *shareWindow;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareWindow = [[TTXMPopupWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        shareWindow.rootViewController = [UIViewController new];
    });
    return shareWindow;
}

/**
 *  返回window上rootViewController.view
 *
 *  @return view
 */
- (UIView *)attachView {
    return self.rootViewController.view;
}

- (void)tapView:(UIGestureRecognizer *)geture {
    
    NSLog(@"sss");
}
@end
