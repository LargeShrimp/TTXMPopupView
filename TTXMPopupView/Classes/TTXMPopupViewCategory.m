//
//  UIView+TTXMPopupViewCategory.m
//  TTXMPopupView
//
//  Created by taitanxiami on 16/1/19.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "TTXMPopupViewCategory.h"
#import <objc/runtime.h>
#import "TTXMPopupWindow.h"
#import <Masonry.h>
static const void *mm_dimReferenceCountKey      = &mm_dimReferenceCountKey;
static const void *mm_dimBackgroundViewKey      = &mm_dimBackgroundViewKey;
static const void *mm_dimAnimationDurationKey   = &mm_dimAnimationDurationKey;
static const void *mm_dimBackgroundAnimatingKey = &mm_dimBackgroundAnimatingKey;


@interface UIView (PopupViewInner)

@property (nonatomic, assign) NSInteger mm_dimReferenceCount;

@end
@implementation UIView (PopupViewInner)

-(NSInteger)mm_dimReferenceCount {
    return [objc_getAssociatedObject(self,mm_dimReferenceCountKey) integerValue];
}

-(void)setMm_dimReferenceCount:(NSInteger)mm_dimReferenceCount {
    
    objc_setAssociatedObject(self,mm_dimReferenceCountKey,@(mm_dimReferenceCount),OBJC_ASSOCIATION_RETAIN);
}

@end
@implementation UIView (TTXMPopupViewCategory)

@dynamic mmDimAniamationing;
@dynamic mmDimAnimationDuration;
@dynamic mmDimBackgroundView;

-(UIView *)mmDimBackgroundView {
    
    UIView *dimView = objc_getAssociatedObject(self, mm_dimBackgroundViewKey);
    if (!dimView) {
        
        dimView = [UIView new];
        [self addSubview:dimView];
        [dimView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        dimView.hidden = YES;
        dimView.layer.zPosition = FLT_MAX;
        self.mmDimAnimationDuration = 0.3;
        objc_setAssociatedObject(self, mm_dimBackgroundViewKey, dimView, OBJC_ASSOCIATION_RETAIN);
        
    }
    return dimView;
}

- (NSTimeInterval)mmDimAnimationDuration {
    return [objc_getAssociatedObject(self, mm_dimAnimationDurationKey) boolValue];
}

-(void)setMmDimAnimationDuration:(NSTimeInterval)mmDimAnimationDuration {
    objc_setAssociatedObject(self, mm_dimAnimationDurationKey, @(mmDimAnimationDuration), OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)mmDimAniamationing {
    return [objc_getAssociatedObject(self, mm_dimBackgroundAnimatingKey) boolValue];
}
- (void)setMmDimAniamationing:(BOOL)mmDimAniamationing {
    objc_setAssociatedObject(self, mm_dimBackgroundAnimatingKey, @(mmDimAniamationing), OBJC_ASSOCIATION_RETAIN);
}

-(void)mm_showDimBackground {
    
    ++self.mm_dimReferenceCount;
    
    if (self.mm_dimReferenceCount > 1) {
        return;
    }
    
    self.mmDimBackgroundView.hidden = NO;
    self.mmDimAniamationing = YES;
    
    if (self == [TTXMPopupWindow shareWindow].attachView) {
        
        [TTXMPopupWindow shareWindow].hidden = NO;
        [[TTXMPopupWindow shareWindow] makeKeyAndVisible];
    }
    
    [UIView animateWithDuration:self.mmDimAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.mmDimBackgroundView.backgroundColor = [UIColor lightGrayColor];
        
    } completion:^(BOOL finished) {
       
        self.mmDimAniamationing = NO;
    }];
}

-(void)mm_hidenDimBackground {
    
    --self.mm_dimReferenceCount;
    if (self.mm_dimReferenceCount > 0) {
        return;
    }
    
    [UIView animateWithDuration:self.mmDimAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
       
        self.mmDimBackgroundView.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        if (finished) {
            
            self.mmDimAniamationing = NO;
            self.mmDimBackgroundView.hidden = YES;
            if (self == [TTXMPopupWindow shareWindow].attachView) {
                
                [TTXMPopupWindow shareWindow].hidden = YES;
                [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
            }
        }
    }];
}
@end
