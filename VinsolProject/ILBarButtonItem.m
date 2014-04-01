//
// ILBarButtonItem.m
// Version 1.0
// Created by Isaac Lim (isaacl.net) on 1/1/13.
//

#import "ILBarButtonItem.h"

@interface ILBarButtonItem() {
    id customTarget;
    UIButton *customButton;
}

@end

@implementation ILBarButtonItem
@synthesize btn;
- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
        buttonWidth:(CGFloat)buttonWidth
       buttonHeight:(CGFloat)buttonHeight
             target:(id)target action:(SEL)action {
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setFrame:CGRectMake(10.0f, 0.0f, buttonWidth, buttonHeight)];
    [self.btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self.btn setImage:image forState:UIControlStateNormal];
    [self.btn setImage:selectedImage forState:UIControlStateHighlighted];
    
    /* Init method inherited from UIBarButtonItem */
    self = [[ILBarButtonItem alloc] initWithCustomView:self.btn];

    if (self) {
        /* Assign ivars */
        customButton = self.btn;
        customImage = image;
        customSelectedImage = selectedImage;
        customTarget = target;
        customAction = action;
    }

    return self;
}

+ (ILBarButtonItem *)barItemWithImage:(UIImage*)image
                        selectedImage:(UIImage*)selectedImage
                         buttonWidth:(CGFloat)buttonWidth
                         buttonHeight:(CGFloat)buttonHeight
                               target:(id)target
                               action:(SEL)action
{
    return [[ILBarButtonItem alloc] initWithImage:image
                                    selectedImage:selectedImage
                                     buttonWidth:buttonWidth
                                     buttonHeight:buttonHeight
                                           target:target
                                           action:action];
}

- (void)setCustomImage:(UIImage *)image {
    customImage = image;
    [customButton setImage:image forState:UIControlStateNormal];
}

- (void)setCustomSelectedImage:(UIImage *)image {
    customSelectedImage = image;
    [customButton setImage:image forState:UIControlStateHighlighted];
}

- (void)setCustomAction:(SEL)action {
    customAction = action;
    
    [customButton removeTarget:nil
                        action:NULL
             forControlEvents:UIControlEventAllEvents];
    
    [customButton addTarget:customTarget
                     action:action
           forControlEvents:UIControlEventTouchUpInside];
}

@end
