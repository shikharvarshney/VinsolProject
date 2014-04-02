//
//  ViewController.h
//  VinsolProject
//
//  Created by Shikhar on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"


@interface ViewController : UIViewController<MYIntroductionDelegate>

-(void)getSliderValues:(float)itemSize interSpace:(float)interSpace animationSpeed:(float)animationSpeed;
@property BOOL isFromSettingsScreen;

@end
