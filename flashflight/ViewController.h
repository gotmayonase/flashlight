//
//  ViewController.h
//  flashflight
//
//  Created by Mike Mayo on 5/3/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UIView *brightnesView;
@property (nonatomic, strong) IBOutlet UIButton *onOffButton;

- (IBAction)toggleLight:(id)sender;
- (IBAction)sliderChanged:(id)sender;

@end
