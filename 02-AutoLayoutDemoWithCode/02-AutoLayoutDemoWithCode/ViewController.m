//
//  ViewController.m
//  02-AutoLayoutDemoWithCode
//
//  Created by qingyun on 16/4/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;
@end

@implementation ViewController


-(UIView *)redView{
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        //设置背景颜色
        _redView.backgroundColor = [UIColor redColor];
        _redView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _redView;
}

-(UIView *)greenView{
    if (_greenView == nil) {
        _greenView = [[UIView alloc] init];
        //设置背景颜色
        _greenView.backgroundColor = [UIColor greenColor];
        _greenView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _greenView;
}

-(UIView *)blueView{
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        //设置背景颜色
        _blueView.backgroundColor = [UIColor blueColor];
        _blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blueView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加红、绿、蓝视图
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.blueView];
    
    //设置约束
    //[self setupLayoutContraintsWithMethod1];
    //[self setupConstraintsWithVFL];
    [self setupConstraintsWithMasonry];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//第一种方式添加约束
-(void)setupLayoutContraintsWithMethod1{
    NSLayoutConstraint *redViewLeft = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.0];
    NSLayoutConstraint *redViewTop = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30.0];
    NSLayoutConstraint *redViewRight = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-30.0];
    NSLayoutConstraint *redViewBottom = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *redViewWidth = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    NSLayoutConstraint *redViewHeight = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *greenRight = [NSLayoutConstraint constraintWithItem:self.greenView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30.0];
    
    NSLayoutConstraint *greenTop = [NSLayoutConstraint constraintWithItem:self.greenView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *greenHeight = [NSLayoutConstraint constraintWithItem:self.greenView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    
    
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.redView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.greenView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *blueBottom = [NSLayoutConstraint constraintWithItem:self.blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30.0];
    
    
    [self.view addConstraints:@[redViewLeft,redViewTop,redViewRight,redViewBottom,redViewWidth,redViewHeight,greenRight,greenTop,greenHeight,blueLeft,blueRight,blueBottom]];
}

//第二种方式（VFL）
-(void)setupConstraintsWithVFL{
    //所有的view
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,_redView,_greenView,_blueView);
    NSNumber *margin = @(3.0);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(margin);
    //红色视图和绿色视图水平方向的约束
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_redView(_greenView)]-30-[_greenView]-30-|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
    //添加红色视图和蓝色视图垂直方向的约束
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_redView(_blueView)]-30-[_blueView]-30-|" options:NSLayoutFormatAlignAllLeading metrics:metrics views:views]];
    
    //添加蓝色视图右边的约束
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_blueView]-30-|" options:0 metrics:metrics views:views]];
    
}
//masonry
-(void)setupConstraintsWithMasonry{
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(@[self.greenView, @30]);
        make.right.equalTo(self.greenView.mas_left).with.offset(-30);
        make.bottom.equalTo(self.blueView.mas_top).with.offset(-30);
        make.size.equalTo(self.greenView);
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView);
        make.bottom.equalTo(@(-30));
        make.right.mas_equalTo(-30);
        make.height.equalTo(self.redView);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
