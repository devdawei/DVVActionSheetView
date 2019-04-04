//
//  TestViewController.m
//  DVVActionSheetView
//
//  Created by David on 2019/4/4.
//  Copyright © 2019 devdawei. All rights reserved.
//

#import "TestViewController.h"
#import "DVVActionSheetView.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)dealloc {
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)([UIImage imageNamed:@"img_tmp_bg"].CGImage);
}

- (IBAction)openAction:(id)sender {
#if 1
//    DVVActionSheetView *actionSheetView = [DVVActionSheetView new];
    DVVActionSheetView *actionSheetView = [[DVVActionSheetView alloc] initWithTitle:@"请选择图片采集方式"];
    NSMutableArray *actions = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        DVVAlertAction *action = [DVVAlertAction actionWithTitle:@"从相册选择" style:DVVAlertActionStyleDefault handler:^(DVVAlertAction * _Nonnull action) {
            NSLog(@"%zd %@", action.indexPath.row, action.title);
        }];
        [actions addObject:action];
    }
    [actionSheetView addActions:actions];
    [actionSheetView show];
#else
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"title" message:@"msg" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Test action" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
#endif
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
