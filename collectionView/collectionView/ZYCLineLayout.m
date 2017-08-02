//
//  ZYCLineLayout.m
//  collectionView
//
//  Created by wpzyc on 2017/7/31.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCLineLayout.h"

@implementation ZYCLineLayout
- (instancetype)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}
/**
 *当collectionview的显示范围发生改变时，是否需要重写布局
 *一旦重写布局，就会重新调用下面的方法：
 *1.prepareLayout
 *2.layoutAttributesForElementsInRect:
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 用来做布局的初始化操作（不建议在init中进行布局的初始化操作）
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width)*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}
/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象；
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 */
/**
 *这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 *这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算CollectionView最中心点的x值
   CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width*0.5;


    //在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //计算cell的中心点x和collectionview中心点x的间距
        CGFloat delta = ABS(attrs.center.x - collectionViewCenterX);
        //根据间距值计算cell的缩放比例
        CGFloat scale = 1.0 - delta/self.collectionView.frame.size.width;
       //计算缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return array;
}
/**
 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGFloat x = proposedContentOffset.x;
    CGFloat y = 0;
    CGSize size = self.collectionView.frame.size;
    CGRect rect = CGRectMake(x, y, size.width, size.height);
    //获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算collectionview中心点x
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width*0.5;
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x-collectionViewCenterX)<ABS(minDelta)) {
            minDelta = attrs.center.x-collectionViewCenterX;
        
        }
        
    }
    //修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
