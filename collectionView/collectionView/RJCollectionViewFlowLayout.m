//
//  RJCollectionViewFlowLayout.m
//  collectionView
//
//  Created by 辉贾 on 16/3/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJCollectionViewFlowLayout.h"

@implementation RJCollectionViewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

/**
 *  数组中保存的是UICollectionViewLayoutAttributes *attrs
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 *
 *  这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 *  这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 计算CollectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // cell的中心点x和collectionView最中心的x值的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        
        // 根据间距值计算cell的缩放比例
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
        
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

/**
 *  当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 *  一旦重新刷新布局，就会重新调用下面的方法
 *
 *  1.prepareLayout
 *  2.layoutAttributesForElementsInRect：
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 * 这个方法在滚动松手的那一刻调用
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}


@end
