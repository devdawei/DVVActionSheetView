//
//  DVVActionSheetCell.m
//  DVVActionSheetView <https://github.com/devdawei/DVVActionSheetView.git>
//
//  Created by 大威 on 2016/9/25.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVActionSheetCell.h"

@implementation DVVActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.bottomLineImageView];
        
        self.textLabel.textColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
        self.selectedBackgroundView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
            view;
        });
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bottomLineImageView.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
}

- (UIImageView *)bottomLineImageView
{
    if (!_bottomLineImageView) {
        _bottomLineImageView = [UIImageView new];
        _bottomLineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _bottomLineImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
