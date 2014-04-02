//
//  CustomColorCell.m
//  VinsolProject
//
//  Created by Meditab on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import "CustomColorCell.h"
#import "ColorName.h"

@implementation CustomColorCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel.text = nil;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel.text = nil;
    self.colorName = nil;
}

- (void)setColorName:(ColorName *)colorName
{
    _colorName = colorName;
    if (colorName != nil)
    {
        self.backgroundColor = colorName.color;
        self.nameLabel.text = colorName.name;
    }
}


@end
