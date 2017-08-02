//
//  ZYCPhotoCell.m
//  collectionView
//
//  Created by wpzyc on 2017/8/1.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCPhotoCell.h"
@interface ZYCPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ZYCPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
    
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
