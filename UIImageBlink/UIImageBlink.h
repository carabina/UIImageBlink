//
//  UIImageBlink.h
//  UIImageBlink
//
/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Studio 609, Peter Hagemeyer. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#ifndef testBlink_UIImageBlink_h
#define testBlink_UIImageBlink_h


#endif


#import <UIKit/UIKit.h>


enum {
    LeftEye = 1,
    RightEye = 2,
    BothEyes = 3
};
typedef NSUInteger EyeType;


@interface UIImageBlink : UIView

@property (strong, nonatomic) NSTimer *timerON;
@property (strong, nonatomic) NSTimer *timerON2;
@property (nonatomic) float slowFlashDuration;
@property (nonatomic) float fastFlashDuration;
@property (nonatomic) float my10_90Duration;
@property (nonatomic) UIImageView* leftImage;
@property (nonatomic) UIImageView* rightImage;
@property (nonatomic) EyeType eyeToFlash;
@property (nonatomic) BOOL pulseFlag;



-(void) setEyeColor:(UIColor*)color;
-(void) showFlashLeft;
-(void) showFlashRight;
-(void) showFlashAlternate;
-(void) showFastFlash;
-(void) showPulse;
-(void) showFlash9010;
-(void) showSlowFlash;

-(void) cleanup;

@end