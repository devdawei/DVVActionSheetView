//
//  DVVActionSheetView.m
//  DVVActionSheetView <https://github.com/devdawei/DVVActionSheetView.git>
//
//  Created by 大威 on 2016/9/25.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVActionSheetView.h"
#import "DVVAlertCell.h"

@interface DVVActionSheetView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *containerView;
#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
#endif
@property (nonatomic, assign) BOOL didConfigUI;

@property (nonatomic, strong) NSMutableArray<DVVAlertAction *> *actionArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *headerBottomLineImageView;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImageView *footerTopLineImageView;

@end

CGFloat const kCellHeight = 44;
CGFloat const kCornerRadius = 14;
static NSString * const kCellIdentifier = @"kCellIdentifier";

@implementation DVVActionSheetView

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
{
    self = [super init];
    if (self)
    {
        [self initSelf];
        
        self.titleLabel.text = title;
        self.messageLabel.text = message;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        [self initSelf];
        
        self.titleLabel.text = title;
    }
    return self;
}

- (void)initSelf
{
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.cornerRadius = kCornerRadius;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self configUI];
}

#pragma mark Public

- (void)addAction:(DVVAlertAction *)action
{
    if (nil == _actionArray) _actionArray = [NSMutableArray array];
    if (DVVAlertActionStyleCancel == action.style)
    {
        [_actionArray insertObject:action atIndex:0];
    }
    else
    {
        [_actionArray addObject:action];
    }
}

- (void)addActions:(NSArray<DVVAlertAction *> *)array
{
    for (DVVAlertAction *action in array)
    {
        [self addAction:action];
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.containerView];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        _containerView.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurEffectView.userInteractionEnabled = NO;
        [_containerView addSubview:_blurEffectView];
    }
    
    [_containerView addSubview:self.headerView];
    [_headerView addSubview:self.titleLabel];
    [_headerView addSubview:self.messageLabel];
    [_headerView addSubview:self.headerBottomLineImageView];
    [_containerView addSubview:self.tableView];
    [_containerView addSubview:self.footerView];
    [_footerView addSubview:self.cancelButton];
    [_footerView addSubview:self.footerTopLineImageView];
    
    /* 设置 constraints 是为了解决不调用 - (void)layoutSubviews 方法 */
    
    NSLayoutConstraint *sT = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *sL = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *sB = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *sR = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [window addConstraints:@[ sT, sL, sB, sR ]];
    
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bivT = [NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bivL = [NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *bivB = [NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *bivR = [NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self addConstraints:@[ bivT, bivL, bivB, bivR ]];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        _blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *t = [NSLayoutConstraint constraintWithItem:_blurEffectView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:_blurEffectView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:_blurEffectView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *r = [NSLayoutConstraint constraintWithItem:_blurEffectView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [_containerView addConstraints:@[ t, l, b, r ]];
    }
    
    _headerBottomLineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *hblibH = [NSLayoutConstraint constraintWithItem:_headerBottomLineImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5];
    NSLayoutConstraint *hblibL = [NSLayoutConstraint constraintWithItem:_headerBottomLineImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_headerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *hblibB = [NSLayoutConstraint constraintWithItem:_headerBottomLineImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *hblibR = [NSLayoutConstraint constraintWithItem:_headerBottomLineImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_headerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [_headerView addConstraints:@[ hblibH, hblibL, hblibB, hblibR ]];
    
    _footerTopLineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *ftlivH = [NSLayoutConstraint constraintWithItem:_footerTopLineImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5];
    NSLayoutConstraint *ftlivT = [NSLayoutConstraint constraintWithItem:_footerTopLineImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *ftlivL = [NSLayoutConstraint constraintWithItem:_footerTopLineImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *ftlivR = [NSLayoutConstraint constraintWithItem:_footerTopLineImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [_footerView addConstraints:@[ ftlivH, ftlivT, ftlivL, ftlivR ]];
    
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundImageView.alpha = 1;
    }];
    
    /* 调试时打开 */
//    self.containerView.backgroundColor = [UIColor redColor];
//    
//    self.headerView.backgroundColor = [UIColor blackColor];
//    self.titleLabel.backgroundColor = [UIColor orangeColor];
//    self.messageLabel.backgroundColor = [UIColor magentaColor];
//    
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
//    
//    self.footerView.backgroundColor = [UIColor orangeColor];
}

#pragma mark - Action

- (void)backgroundImageViewClickAction:(UITapGestureRecognizer *)sender
{
    [self removeSelf];
}

- (void)cancelButtonTouchDownAction:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
}

- (void)cancelButtonTouchDragExitAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        sender.backgroundColor = [UIColor clearColor];
    }];
}

- (void)cancelButtonTouchUpInsideAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        sender.backgroundColor = [UIColor clearColor];
    }];
    [self removeSelf];
}

- (void)removeSelf
{
    CGRect frame = _containerView.frame;
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundImageView.alpha = 0;
        _containerView.frame = CGRectMake(frame.origin.x, [UIScreen mainScreen].bounds.size.height, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _actionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DVVAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DVVAlertCell *tmpCell = (DVVAlertCell *)cell;
    
    tmpCell.textLabel.text = _actionArray[indexPath.row].title;
    
    if (_actionArray.count - 1 == indexPath.row) tmpCell.bottomLineImageView.hidden = YES;
    else tmpCell.bottomLineImageView.hidden = NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DVVAlertAction *action = _actionArray[indexPath.row];
    action.indexPath = indexPath;
    action.handler(action);
    [self removeSelf];
}

#pragma mark - UI

- (void)configUI
{
    BOOL iPhoneX = NO;
    if ([UIScreen mainScreen].bounds.size.width == 812 ||
        [UIScreen mainScreen].bounds.size.height == 812) {
        // iPhone X
        iPhoneX = YES;
    }
    
    CGFloat margin = 8;
    
    CGSize size = self.bounds.size;
    CGSize screenSize = size;
    if (size.width > 414) size.width = 414;
    // 减去边距
    size.width -= margin * 2;
    if (iPhoneX) {
        if ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) {
            size.width -= margin * 2; // 竖屏情况下的iPhone X，需要更大的边距
            size.height -= 44 + 34;
        } else {
            size.height -= (34 - 5 - 8) + 34; // 5是iPhone X的功能条高度，8是iPhone X的功能条距离屏幕底部的高度
        }
    } else {
        size.height -= margin * 2;
    }
    
    CGFloat titleHeight = [DVVActionSheetView heightWithString:_titleLabel.text width:size.width - kCornerRadius*2 font:_titleLabel.font];
    if (0 != titleHeight) titleHeight += margin;
    CGFloat messageHeight = [DVVActionSheetView heightWithString:_messageLabel.text width:size.width - kCornerRadius*2 font:_messageLabel.font];;
    if (0 != messageHeight) messageHeight += margin;
    CGFloat titleTopMargin = 0;
    CGFloat titleBottomMargin = 0;
    if (0 != titleHeight) titleTopMargin = margin;
    if (0 != titleHeight && 0 == messageHeight) titleBottomMargin = margin;
    CGFloat messageTopMargin = 0;
    CGFloat messageBottomMargin = 0;
    if (0 != messageHeight) {messageTopMargin = 2; messageBottomMargin = margin;};
    if (0 != messageHeight && 0 == titleHeight) messageTopMargin = margin;
    CGFloat headerHeight = titleTopMargin + titleHeight + titleBottomMargin + messageTopMargin + messageHeight + messageBottomMargin;
    
    CGFloat cancelHeight = 50;
    CGFloat footerHeight = cancelHeight;
    
    CGFloat tableHeight = 0;
    if (headerHeight + footerHeight + _actionArray.count*50 > size.height)
    {
        tableHeight = size.height - headerHeight - footerHeight;
    }
    else
    {
        tableHeight = _actionArray.count*50;
    }
    
    CGFloat containerHeight = headerHeight + tableHeight + footerHeight;
    
    _headerView.frame = CGRectMake(0, 0, size.width, headerHeight);
    
    _titleLabel.frame = CGRectMake(kCornerRadius/2.0, titleTopMargin, size.width - kCornerRadius, titleHeight);
    _messageLabel.frame = CGRectMake(kCornerRadius/2.0, CGRectGetMaxY(_titleLabel.frame) + titleBottomMargin + messageTopMargin, size.width - kCornerRadius, messageHeight);
    
    _tableView.frame = CGRectMake(0, headerHeight, size.width, tableHeight);
    
    _footerView.frame = CGRectMake(0, containerHeight - cancelHeight, size.width, cancelHeight);
    _cancelButton.frame = CGRectMake(0, 0, size.width, cancelHeight);
    
    if (_didConfigUI)
    {
        _containerView.frame = CGRectMake((screenSize.width - size.width) / 2.0, screenSize.height - containerHeight - (iPhoneX ? 34 : margin), size.width, containerHeight);
    }
    else
    {
        _containerView.frame = CGRectMake((screenSize.width - size.width) / 2.0, screenSize.height, size.width, containerHeight);
        [UIView animateWithDuration:0.25 animations:^{
            _containerView.frame = CGRectMake((screenSize.width - size.width) / 2.0, screenSize.height - containerHeight - (iPhoneX ? 34 : margin), size.width, containerHeight);
        }];
        _didConfigUI = YES;
    }
    
    if (tableHeight >= _actionArray.count*50) _tableView.bounces = NO;
    else _tableView.bounces = YES;
}

#pragma mark - Lazy load

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageViewClickAction:)];
        [_backgroundImageView addGestureRecognizer:tapGes];
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.alpha = 0;
    }
    return _backgroundImageView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    }
    return _containerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:NSClassFromString(NSStringFromClass([DVVAlertCell class])) forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [UIView new];
    }
    return _headerView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
    }
    return _messageLabel;
}

- (UIImageView *)headerBottomLineImageView
{
    if (!_headerBottomLineImageView) {
        _headerBottomLineImageView = [UIImageView new];
        _headerBottomLineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _headerBottomLineImageView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
    }
    return _footerView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateSelected];
        
        [_cancelButton setTitleColor:[UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1] forState:UIControlStateSelected];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchDownAction:) forControlEvents:UIControlEventTouchDown];
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton addTarget:self action:@selector(cancelButtonTouchDragExitAction:) forControlEvents:UIControlEventTouchDragExit];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cancelButton;
}

- (UIImageView *)footerTopLineImageView
{
    if (!_footerTopLineImageView) {
        _footerTopLineImageView = [UIImageView new];
        _footerTopLineImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _footerTopLineImageView;
}

#pragma mark -

+ (CGFloat)heightWithString:(NSString *)string
                      width:(CGFloat)width
                       font:(UIFont *)font
{
    if (0 == string.length) return 0;
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *fontAttributeDict = @{ NSFontAttributeName: font };
    CGFloat height = [string boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:fontAttributeDict context:nil].size.height;
    return height;
}

+ (CGFloat)widthWithString:(NSString *)string
                      font:(UIFont *)font
{
    if (0 == string.length) return 0;
    
    CGSize size = CGSizeMake(MAXFLOAT, font.lineHeight);
    NSDictionary *fontAttributeDict = @{ NSFontAttributeName: font };
    CGFloat width = [string boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:fontAttributeDict context:nil].size.width;
    return width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
