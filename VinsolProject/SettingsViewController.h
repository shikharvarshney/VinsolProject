//
//  SettingsViewController.h
//  VinsolProject
//
//  Created by Meditab on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController{
    float itemSizeValue;
    float interSpacingValue;
    float animationSpeed;
}

@property (strong,nonatomic) IBOutlet UISlider * itemSizeSlider;
@property (strong,nonatomic) IBOutlet UISlider * interSpacingSlider;
@property (strong,nonatomic) IBOutlet UISlider * animationSlider;

@property (strong,nonatomic) NSString * str_itemSizeSliderValue;
@property (strong,nonatomic) NSString * str_interSpacingSliderValue;
@property (strong,nonatomic) NSString * str_animationSliderValue;






@property (strong,nonatomic) id obj_sliderValues;



@end
