//
//  UIView+TTXMPopupViewCategory.h
//  TTXMPopupView
//
//  Created by taitanxiami on 16/1/19.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TTXMPopupViewCategory)


@property (nonatomic, strong) UIView *mmDimBackgroundView;
/**
 *  动画时间
 */

@property (nonatomic, assign) NSTimeInterval mmDimAnimationDuration;
/**
 *  是否动画
 */
@property (nonatomic, assign) BOOL mmDimAniamationing;

- (void)mm_showDimBackground;
- (void)mm_hidenDimBackground;

@end
