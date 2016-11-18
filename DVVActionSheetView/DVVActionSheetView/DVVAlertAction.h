//
//  DVVAlertAction.h
//  DVVActionSheetView <https://github.com/devdawei/DVVActionSheetView.git>
//
//  Created by 大威 on 2016/9/25.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVVAlertAction;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DVVAlertActionStyle) {
    DVVAlertActionStyleDefault = 0,
    DVVAlertActionStyleCancel,
    DVVAlertActionStyleDestructive
};

typedef void(^DVVAlertActionHandler)(DVVAlertAction * action);

@interface DVVAlertAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) DVVAlertActionStyle style;
@property (nonatomic, copy) DVVAlertActionHandler handler;
- (void)setHandler:(DVVAlertActionHandler _Nonnull)handler;
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 初始化 title style handler

 @param title   title
 @param style   style
 @param handler handler

 @return DVVAlertAction
 */
+ (DVVAlertAction *)actionWithTitle:(NSString *)title
                              style:(DVVAlertActionStyle)style
                            handler:(DVVAlertActionHandler)handler;

@end

NS_ASSUME_NONNULL_END
