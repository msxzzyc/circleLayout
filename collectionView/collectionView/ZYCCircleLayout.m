//
//  ZYCCircleLayout.m
//  collectionView
//
//  Created by wpzyc on 2017/8/2.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCCircleLayout.h"
@interface ZYCCircleLayout()
/** 布局属性 */
@property(nonatomic,strong)NSMutableArray *attrsArray;
@end
@implementation ZYCCircleLayout

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
   
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
 
    return self.attrsArray;
}
/**
 这个方法需要返回indexPath位置对应cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat radius = 70;
    //圆心的位置
    CGFloat oX = self.collectionView.frame.size.width*0.5;
    CGFloat oY = self.collectionView.frame.size.height*0.5;
    
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attrs.size = CGSizeMake(50, 50);
        CGFloat angle = (2*M_PI/count)*indexPath.item;
        CGFloat centerX = oX + radius*sin(angle);
        CGFloat centerY = oY + radius*cos(angle);
        attrs.center = CGPointMake(centerX, centerY);
    

    return attrs;
}
@end
