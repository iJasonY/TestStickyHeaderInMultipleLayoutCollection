//
//  DoubleScrollViewController.m
//  TestStickyHeaderInMultipleLayoutCollection
//
//  Created by Jason on 16/3/31.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "DoubleScrollViewController.h"

#import "TopView.h"

@interface DoubleScrollViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) TopView *topView;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation DoubleScrollViewController

static NSString *const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.view.frame))];
    [self.view addSubview:self.scrollView];
    self.scrollView.delaysContentTouches = NO;

    self.scrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetHeight(self.view.frame) + 114);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSInteger item = indexPath.item;
    // Configure the cell
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}



#pragma mark <UICollectionViewDataSource>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}



- (TopView *)topView
{
    if (!_topView) {
        self.topView = [UIView instanceWithNibName:@"TopView" bundle:nil owner:nil];
        _topView.frame = CGRectMake(0, 0, ScreenWidth, 223);
    }
    return _topView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((ScreenWidth - 12 * 3) / 2, (ScreenWidth - 12 * 3) / 2 + 45);
        layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
        layout.minimumLineSpacing = 12.0f;
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 223, ScreenWidth, CGRectGetHeight(self.view.frame) - 109) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
