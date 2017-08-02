//
//  ViewController.m
//  collectionView
//
//  Created by wpzyc on 2017/7/31.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ViewController.h"
#import "ZYCLineLayout.h"
#import "ZYCPhotoCell.h"
#import "ZYCCircleLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** collectionView */
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation ViewController
static NSString *const ZYCPhotoCellId = @"photo";
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建布局
    ZYCCircleLayout *layout = [[ZYCCircleLayout alloc]init];
    
    
    //创建collectionView 必须在创建时传layout
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate =self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYCPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:ZYCPhotoCellId];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZYCLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[ZYCCircleLayout alloc]init] animated:YES];
    }else{
        ZYCLineLayout *layout = [[ZYCLineLayout alloc]init];
        layout.itemSize =CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }

    
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYCPhotoCellId forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item+1];
    return cell;
}
#pragma mark - <UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


@end
