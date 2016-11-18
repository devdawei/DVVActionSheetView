//
//  DVVAlertAction.m
//  DVVActionSheetView <https://github.com/devdawei/DVVActionSheetView.git>
//
//  Created by 大威 on 2016/9/25.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVAlertAction.h"

@implementation DVVAlertAction

+ (DVVAlertAction *)actionWithTitle:(NSString *)title
                              style:(DVVAlertActionStyle)style
                            handler:(DVVAlertActionHandler)handler
{
    DVVAlertAction *action = [DVVAlertAction new];
    action.title = title;
    action.style = style;
    action.handler = handler;
    
    return action;
}

@end
