//
//  CollectionViewController.m
//  TestStickyHeaderInMultipleLayoutCollection
//
//  Created by Jason on 16/3/31.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CollectionViewController.h"
#import "TopView.h"


typedef NS_ENUM(NSInteger, HeaderVectorType) {
    /// >>  收藏
    HeaderVectorTypeCollection = 0,
    /// >>  行程
    HeaderVectorTypeTrip,

};

@interface CollectionViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) TopView *topView;
@property (assign, nonatomic) HeaderVectorType currentType;


@end

@implementation CollectionViewController

static NSString *const reuseIdentifier = @"Cell";


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((ScreenWidth - 12 * 3) / 2, (ScreenWidth - 12 * 3) / 2 + 45);
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    layout.minimumLineSpacing = 12.0f;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 10);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"%s--%@", __func__, NSStringFromCGPoint(self.collectionView.contentOffset));
    //     self.collectionView.contentOffset.y<=0?(self.collectionView.contentOffset.y-128):self.collectionView.contentOffset.y;
    //    self.topView.top = -(self.collectionView.contentOffset.y+287);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    [self setUp];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    [self.topView.favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView.tripBtn addTarget:self action:@selector(tripBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

- (void)setUp
{
    UIEdgeInsets insets = UIEdgeInsetsMake(223 - 0, 0, 0, 0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.topView.top = -(self.collectionView.contentOffset.y + 223);

    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat contentOffsetY = -(self.collectionView.contentOffset.y + 223);

    if (contentOffsetY <= -109 - 45.0f) {
        self.topView.top = -109 - 45.0f;
    }

    if (contentOffsetY >= 0) { // Y锁定在0，高度增加拉伸的数量
        self.topView.top = 0;
        CGFloat orginHeight = self.topView.height;
        self.topView.height = 223.0 + contentOffsetY;
        NSLog(@"orgoinHeight%f----calcHeight%f", orginHeight, self.topView.height);
    }

    NSLog(@"orgion:%@--transformer%f", NSStringFromCGPoint(scrollView.contentOffset), -(self.collectionView.contentOffset.y + 223));
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (self.currentType == HeaderVectorTypeCollection) {

        return 4;
    }
    else if (self.currentType == HeaderVectorTypeTrip) {
        return 10;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSInteger item = indexPath.item;
    // Configure the cell
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}



#pragma mark <UICollectionViewDelegate>

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (self.currentType == HeaderVectorTypeCollection) {
        return CGSizeMake((ScreenWidth - 12 * 3) / 2, (ScreenWidth - 12 * 3) / 2);
    }
    else {
        return CGSizeMake((ScreenWidth - 24), (ScreenWidth - 24) / 2);
    }

    return CGSizeZero;
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        if (self.currentType == HeaderVectorTypeCollection) {
            return UIEdgeInsetsMake(0, 12, 12, 12);
        }
        else {
            return UIEdgeInsetsMake(12, 0, 12, 0);
        }
    }
    else {
        return UIEdgeInsetsMake(0, 12, 12, 12);
    }
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.currentType == HeaderVectorTypeCollection) {
        return 10.0f;
    }
    else {
        return 10.0;
    }
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.currentType == HeaderVectorTypeCollection) {
        return 10.0f;
    }
    else {
        return 0;
    }
}



//MARK: - event
- (void)favBtnClick:(UIButton *)sender
{
    self.currentType = HeaderVectorTypeCollection;

    [self.collectionView reloadData];
}

- (void)tripBtnClick:(UIButton *)sender
{

    self.currentType = HeaderVectorTypeTrip;

    [self.collectionView reloadData];
}

//MARK: - getter/setter

- (TopView *)topView
{
    if (!_topView) {
        self.topView = [UIView instanceWithNibName:@"TopView" bundle:nil owner:nil];
        _topView.frame = CGRectMake(0, 0, ScreenWidth, 223);
    }
    return _topView;
}

@end
