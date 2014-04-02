//
//  CustomColorCell.h
//  VinsolProject
//
//  Created by Meditab on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorName;

@interface CustomColorCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) ColorName *colorName;

@end