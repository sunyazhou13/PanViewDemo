//
//  ViewController.m
//  PanViewDemo
//
//  Created by sunyazhou on 2019/9/26.
//  Copyright © 2019 www.sunyazhou.com. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIImageView *widgetView;
@property (weak, nonatomic) IBOutlet UILabel *bubbleTitleLabel;


@property (nonatomic, strong) MASConstraint *leftConstraint;
@property (nonatomic, strong) MASConstraint *topConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(50, 10, 50, 10));
    }];
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    [self.widgetView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置边界条件约束，保证内容可见，优先级1000
        make.left.greaterThanOrEqualTo(self.greenView.mas_left);
        make.right.lessThanOrEqualTo(self.greenView.mas_right);
        make.top.greaterThanOrEqualTo(self.greenView.mas_top);
        make.bottom.lessThanOrEqualTo(self.greenView.mas_bottom);
        
        self.leftConstraint = make.centerX.equalTo(self.greenView.mas_left).with.offset(screenWidth - 20).priorityHigh(); // 优先级要比边界条件低
        self.topConstraint = make.centerY.equalTo(self.greenView.mas_top).with.offset(screenHeight - 100).priorityHigh(); // 优先级要比边界条件低
        make.width.height.mas_equalTo(@100);
    }];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panWithGesture:)];
    [self.greenView addGestureRecognizer:pan];
    
    
    [self.bubbleTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@26);
        make.bottom.equalTo(self.widgetView.mas_top);
        make.left.greaterThanOrEqualTo(self.greenView.mas_left).offset(0);
        make.right.lessThanOrEqualTo(self.greenView.mas_right).offset(0);
        make.centerX.lessThanOrEqualTo(self.widgetView.mas_right).offset(10);
        make.centerX.greaterThanOrEqualTo(self.widgetView.mas_left).offset(-10);
    }];
    
}

- (void)panWithGesture:(UIPanGestureRecognizer *)pan {
    CGPoint touchPoint = [pan locationInView:self.greenView];
    self.leftConstraint.offset = touchPoint.x;
    self.topConstraint.offset = touchPoint.y;
}



@end
