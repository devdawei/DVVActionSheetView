//
//  ViewController.m
//  DVVActionSheetView
//
//  Created by 大威 on 2016/10/31.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "ViewController.h"
#import "DVVActionSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openAction:(id)sender
{
//    DVVActionSheetView *actionSheetView = [DVVActionSheetView new];
    DVVActionSheetView *actionSheetView = [[DVVActionSheetView alloc] initWithTitle:@"请选择图片采集方式"];
    NSMutableArray *actions = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        DVVAlertAction *action = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
            NSLog(@"%zd %@", action.indexPath.row, action.title);
        }];
        [actions addObject:action];
    }
    [actionSheetView addActions:actions];
    [actionSheetView show];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
