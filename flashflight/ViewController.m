//
//  ViewController.m
//  flashflight
//
//  Created by Mike Mayo on 5/3/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController {
  AVCaptureSession *session;
  AVCaptureDevice *device;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  if (![device hasTorch]) {
    [self.onOffButton setHidden:YES];
  } else {
    [self toggleLight:self.onOffButton];
  }
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)becameActive {
  if (self.onOffButton.selected) {
    [self turnOnLight];
  }
}

-(void)viewDidUnload {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)toggleLight:(UIButton *)button {
  [self toggleFlashlight];
  [button setSelected:!button.selected];
}

- (void)toggleFlashlight {
  if (device.torchMode == AVCaptureTorchModeOff)
  {
    session = [[AVCaptureSession alloc] init];
    
    // Create device input and add to current session
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error: nil];
    [session addInput:input];
    
    // Create video output and add to current session
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:output];
    [session startRunning];
    [self turnOnLight];
    // Start the session
    [self.brightnesView setHidden:NO];
  }
  else
  {
    [self.brightnesView setHidden:YES];
    [session stopRunning];
    session = nil;
  }
}

- (void)turnOnLight {
  // Start session configuration
  [session beginConfiguration];
  [device lockForConfiguration:nil];
  
  // Set torch to on
  NSError *error;
  [device setTorchModeOnWithLevel:self.slider.value / 10 error:&error];
  if (error) NSLog(@"Error setting torch on: %@", error);
  
  [device unlockForConfiguration];
  [session commitConfiguration];
}

- (float)calculateSliderLevel {
  float level = round(self.slider.value);
  
  return level;
}

- (void)sliderChanged:(UISlider *)slider {
  [slider setValue:[self calculateSliderLevel] animated:YES];
  [self turnOnLight];
}

@end
