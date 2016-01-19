//
//  TTXMPopupWindow.h
//  TTXMPopupView
//
//  Created by taitanxiami on 16/1/19.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTXMPopupWindow : UIWindow

@property (nonatomic, strong) UIView *attachView;
+ (instancetype) shareWindow;

@end
