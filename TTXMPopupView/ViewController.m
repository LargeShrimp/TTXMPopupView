//
//  ViewController.m
//  TTXMPopupView
//
//  Created by taitanxiami on 16/1/19.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "ViewController.h"
#import "TTXMPopupWindow.h"
#import "TTXMPopupViewCategory.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)loadView {
    NSLog(@"window = %@",[[UIApplication sharedApplication] keyWindow]);

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"window = %@",[[UIApplication sharedApplication] keyWindow]);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *attachView = [TTXMPopupWindow shareWindow].attachView;
    [attachView mm_showDimBackground];
    NSLog(@"window = %@",[[UIApplication sharedApplication] keyWindow]);

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [attachView mm_hidenDimBackground];
        NSLog(@"window = %@",[[UIApplication sharedApplication] keyWindow]);



    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
