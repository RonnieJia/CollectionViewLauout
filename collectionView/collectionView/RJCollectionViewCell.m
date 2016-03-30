//
//  RJCollectionViewCell.m
//  collectionView
//
//  Created by 辉贾 on 16/3/30.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "RJCollectionViewCell.h"

@implementation RJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:imageView];
    self.imgView = imageView;
}
@end
