//
//  UINavigationItem+Additions.m
//  IMSGO
//
//  Created by Meditab on 11/12/13.
//  Copyright (c) 2013 Meditab. All rights reserved.
//

#import "UINavigationItem+Additions.h"

@implementation UINavigationItem (Additions)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = -10;
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil]];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil]];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self setRightBarButtonItem:rightBarButtonItem];
    }
}

@end
