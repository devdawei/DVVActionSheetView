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
    
    DVVAlertAction *cancelAction = [DVVAlertAction actionWithTitle:@"拍照" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction2 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction3 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction4 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction5 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction6 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
    DVVAlertAction *okAction7 = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
        NSLog(@"%zd %@", action.indexPath.row, action.title);
    }];
    
//    [actionSheetView addAction:cancelAction];
//    [actionSheetView addAction:okAction];
//    [actionSheetView addActions:@[ cancelAction, okAction ]];
    
    [actionSheetView addActions:@[ cancelAction, okAction, okAction2, okAction3, okAction4, okAction5, okAction6, okAction7 ]];
    
    [actionSheetView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
