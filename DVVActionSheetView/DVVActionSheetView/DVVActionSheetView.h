//
//  DVVActionSheetView.h
//  DVVActionSheetView
//
//  Created by 大威 on 2016/9/25.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVAlertAction.h"

@interface DVVActionSheetView : UIView

/**
 初始化 title 和 message

 @param title   title
 @param message message

 @return instancetype
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message;

/**
 初始化 title

 @param title title

 @return instancetype
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 添加一个 Action

 @param action DVVAlertAction
 */
- (void)addAction:(DVVAlertAction *)action;

/**
 添加多个 Action

 @param array 含有多个 Action 的数组
 */
- (void)addActions:(NSArray<DVVAlertAction *> *)array;

/**
 显示
 */
- (void)show;

@end
