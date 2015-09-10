//
//  ViewController.m
//  CenteringConstraints
//
//  Created by Adusa on 15/9/10.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ViewController.h"
#import "ConstraintsHelper.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UILabel*_label;
    NSMutableArray *_array;
    BOOL _is;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    UIBarButtonItem *go=[[UIBarButtonItem alloc]initWithTitle:@"Go" style:UIBarButtonItemStyleDone target:self action:@selector(go:)];
    self.navigationItem.rightBarButtonItem=go;
    _array=[NSMutableArray array];
    _is=NO;
    [self createLabel];
    [self changePoint:CGPointMake(100, 100) AndSize:CGSizeMake(100, 100)];
    [self.view addConstraints:_array];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)go:(UIBarButtonItem *)item
{
    [self.view removeConstraints:_array];
    [_array removeAllObjects];
    if (_is) {
        [self changePoint:CGPointMake(100, 100) AndSize:CGSizeMake(100, 100)];
        
    }else
    {
        [_array addObjectsFromArray:[_label sizeConstraints:CGSizeMake(100, 100)]];
        [_array addObjectsFromArray:[_label constraintsLimitingViewToSuperviewBounds]];
        [_array addObject:[_label centerXConstraint]];
        [_array addObject:[_label centerYConstraint]];
    }
    _is=!_is;
    [self.view addConstraints:_array];
    [UIView animateWithDuration:0.5f animations:^()
     {
         [self.view layoutIfNeeded];
     }];
}

-(void)createLabel
{
    _label=[[UILabel alloc]init];
    _label.text=@"_label";
    _label.textAlignment=NSTextAlignmentCenter;
    _label.textColor=[UIColor yellowColor];
    _label.backgroundColor=[UIColor grayColor];
    _label.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:_label];
}

-(void)changePoint:(CGPoint)point AndSize:(CGSize)size
{
    [_array addObjectsFromArray:[_label positionConstraints:point]];
    [_array addObjectsFromArray:[_label sizeConstraints:size]];
    [_array addObjectsFromArray:[_label constraintsLimitingViewToSuperviewBounds]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
