//
//  ViewController.m
//  TestStickyHeaderInMultipleLayoutCollection
//
//  Created by Jason on 16/3/31.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"

#import "CollectionViewController.h"
#import "DoubleScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender
{
    CollectionViewController *collectionnVC = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionnVC animated:YES];
}

- (IBAction)scrollBtnClick:(UIButton *)sender
{
    DoubleScrollViewController *vc = [[DoubleScrollViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
