//
//  ViewController.m
//  VinsolProject
//
//  Created by Shikhar on 31/03/14.
//  Copyright (c) 2014 Meditab. All rights reserved.
//

#import "ViewController.h"
#import "ProjectLayout.h"
#import "ColorName.h"
#import "CustomColorCell.h"
#import "AddCell.h"
#import "ColorSectionHeaderView.h"
#import "ColorSectionFooterView.h"
#import "ILBarButtonItem.h"
#import "UINavigationItem+Additions.h"
#import "SettingsViewController.h"



@interface ViewController () <ColorSectionHeaderDelegate, ColorSectionFooterDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    float cellSize;
    float cellSpacing;
    float DeleteAnimationSpeed;
}

@property (nonatomic, weak) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * sectionedColorNames;


- (void)addNewItemInSection:(NSUInteger)section;
- (void)deleteItemAtIndexPath:(NSIndexPath*)indexPath;

- (void)insertSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;

@end

@implementation ViewController
@synthesize isFromSettingsScreen;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // this method will make this app complatible for both the existing version system of iOS i.e before and after iOS 7.0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout=NO;
    }
    
    
    
    self.title = @"Color Grid";
    //initial values for the variable cellAttributes
    cellSize = 80.0f;
    cellSpacing = 20.0f;
    DeleteAnimationSpeed = 0.80f;
                                      
    // This array will contain the ColorName objects that populate the CollectionView, one array per section
    self.sectionedColorNames = [NSMutableArray arrayWithObjects:[NSMutableArray array], nil];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    // Allocate and configure the layout.
    ProjectLayout *layout = [[ProjectLayout alloc] init];
    layout.minimumInteritemSpacing = cellSpacing;
    layout.minimumLineSpacing = 20.f;
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f);
    
    // Bigger items for iPad
    //layout.itemSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? CGSizeMake(120, 120) : CGSizeMake(80, 80);
    
    // uncomment this to see the default flow layout behavior
    //[layout makeProjectNormal];
    
    
    // Allocate and configure a collection view
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    
    // Register reusable items
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AddCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([AddCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomColorCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([CustomColorCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ColorSectionHeaderView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:NSStringFromClass([ColorSectionHeaderView class])];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ColorSectionFooterView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:NSStringFromClass([ColorSectionFooterView class])];
    
    // Add to view
    [self.view addSubview:collectionView];
    // this is for adding the introduction view for the app.
    if (!isFromSettingsScreen) {
        [self buildIntro];
    }
    
}


-(void)buildIntro{
    
    
    //self.navigationController.navigationBar.translucent = YES;
    //Create Stock Panel with header
    UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Welcome to Vinsol Demo Project" description:@"This app is my submission for the exercise which was asked to be completed by me. This app contains many advancement in terms of UI and functionality as asked by the employer. " image:nil header:headerView];
    
    //Create Stock Panel With Image
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Features of the application" description:@"1.This app shows you a grid of random colors.\n 2.You can add as many a grid elements you like \n 3.You can also diversify the sections here and continue to add the grid elements in each section." image:[UIImage imageNamed:@"ForkImage.png"]];
    
    //Create Panel From Nib
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel3"];
    
    
    //Add panels to an array
    NSArray *panels = @[panel1, panel2, panel3];
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Toronto, ON.jpg"];
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %d", panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    ILBarButtonItem * btn_settings = [ILBarButtonItem barItemWithImage:[UIImage imageNamed:@"settings.png"] selectedImage:[UIImage imageNamed:@"settings.png"] buttonWidth:30.0f buttonHeight:30.0f target:self action:@selector(btn_setting_click:)];
    [self.navigationItem addRightBarButtonItem:btn_settings];
    NSLog(@"Introduction did finish");
    isFromSettingsScreen = TRUE;
}


#pragma mark - Object insert/remove

- (void)addNewItemInSection:(NSUInteger)section
{
    ColorName *cn = [ColorName randomColorName];
    NSMutableArray *colorNames = self.sectionedColorNames[section];
    [colorNames addObject:cn];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:colorNames.count-1 inSection:section]]];
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *colorNames = self.sectionedColorNames[indexPath.section];
    [colorNames removeObjectAtIndex:indexPath.item];
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:DeleteAnimationSpeed];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [UIView commitAnimations];
}

- (void)insertSectionAtIndex:(NSUInteger)index
{
    [self.sectionedColorNames insertObject:[NSMutableArray array] atIndex:index];
    
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
}

- (void)deleteSectionAtIndex:(NSUInteger)index
{
    // no checking if section exists - this is somewhat unsafe
    [self.sectionedColorNames removeObjectAtIndex:index];
    
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
    
}

#pragma mark - Header/Footer Delegates

- (void)colorSectionFooterAddSectionPressed:(ColorSectionFooterView *)footerView
{
    if (footerView.sectionIndex != NSNotFound)
    {
        [self insertSectionAtIndex:footerView.sectionIndex+1];
    }
}

- (void)colorSectionHeaderDeleteSectionPressed:(ColorSectionHeaderView *)headerView
{
    if (headerView.sectionIndex != NSNotFound)
    {
        [self deleteSectionAtIndex:headerView.sectionIndex];
    }
}

#pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{   NSLog(@"The number of sections are %d",self.sectionedColorNames.count);
    return self.sectionedColorNames.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Always one extra cell for the "add" cell
    NSMutableArray *sectionColorNames = self.sectionedColorNames[section];
    return sectionColorNames.count + 1;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * view = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        ColorSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:NSStringFromClass([ColorSectionHeaderView class])
                                                                                   forIndexPath:indexPath];
        header.sectionIndex = indexPath.section;
        header.hideDelete = collectionView.numberOfSections == 1; // hide when only one section
        header.delegate = self;
        view = header;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        ColorSectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                            withReuseIdentifier:NSStringFromClass([ColorSectionFooterView class])
                                                                                   forIndexPath:indexPath];
        footer.sectionIndex = indexPath.section;
        footer.delegate = self;
        view = footer;
    }
    
    return view;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    NSArray *colorNames = self.sectionedColorNames[indexPath.section];
    if (indexPath.row == colorNames.count)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AddCell class])
                                                         forIndexPath:indexPath];
    }
    else
    {
        CustomColorCell * cnCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CustomColorCell class])
                                                                          forIndexPath:indexPath];
        cnCell.colorName = colorNames[indexPath.item];
        cell = cnCell;
    }
    
    return cell;
}


#pragma mark - UICollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(cellSize, cellSize);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // Upon tapping an item, delete it. If it's the last item (the add cell), add a new one
    NSArray *colorNames = self.sectionedColorNames[indexPath.section];
    
    if (indexPath.item == colorNames.count)
    {
        [self addNewItemInSection:indexPath.section];
    }
    else
    {
        [self deleteItemAtIndexPath:indexPath];
    }
}

-(IBAction)btn_setting_click:(id)sender{
    
   SettingsViewController * settingsController = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    settingsController.obj_sliderValues = self;
    settingsController.str_itemSizeSliderValue = [[NSNumber numberWithFloat:cellSize] stringValue];
    settingsController.str_interSpacingSliderValue = [[NSNumber numberWithFloat:cellSpacing] stringValue];
    settingsController.str_animationSliderValue = [[NSNumber numberWithFloat:DeleteAnimationSpeed] stringValue];;
    UINavigationController * settingsNavigation = [[UINavigationController alloc] initWithRootViewController:settingsController];
    [self presentViewController:settingsNavigation animated:YES completion:nil];
    
}

-(void)getSliderValues:(float)itemSize interSpace:(float)interSpace animationSpeed:(float)animationSpeed{
    
    cellSize = itemSize;
    cellSpacing = interSpace;
    DeleteAnimationSpeed = animationSpeed;
}


@end

