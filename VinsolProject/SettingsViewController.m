//
//  SettingsViewController.m
//  VinsolProject
//
//  Created by Meditab on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController


@synthesize itemSizeSlider;
@synthesize interSpacingSlider;
@synthesize animationSlider;
@synthesize obj_sliderValues;
@synthesize str_itemSizeSliderValue;
@synthesize str_animationSliderValue;
@synthesize str_interSpacingSliderValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    itemSizeSlider.value = [str_itemSizeSliderValue floatValue];
    interSpacingSlider.value = [str_interSpacingSliderValue floatValue];
    animationSlider.value = [str_animationSliderValue floatValue];
}

-(IBAction)itemSizeSlider_valueChanged:(id)sender{
    itemSizeValue = itemSizeSlider.value;
}

-(IBAction)interSpacingSlider_valueChanged:(id)sender{
    interSpacingValue = interSpacingSlider.value;
}

-(IBAction)animationSlider_valueChanged:(id)sender{
    animationSpeed = animationSlider.value;
}

-(IBAction)btn_done_click:(id)sender{
    
    [self.obj_sliderValues getSliderValues:itemSizeSlider.value interSpace:interSpacingSlider.value animationSpeed:animationSlider.value];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
