//
//  UIImageBlink.m
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

#import <Foundation/Foundation.h>
#import "UIImageBlink.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageBlink



@synthesize rightImage;
@synthesize leftImage;
@synthesize slowFlashDuration;
@synthesize fastFlashDuration;
@synthesize eyeToFlash;
@synthesize my10_90Duration;
@synthesize pulseFlag;




-(void) showFlashLeft{
    [self cleanup];
    [self startSlowFlashing:LeftEye];
    [self setNeedsDisplay];
}

-(void) showFlashRight{
    [self cleanup];
    [self startSlowFlashing:RightEye];
    [self setNeedsDisplay];
}


-(void) showFlashAlternate{
    [self cleanup];
    [self startFlipFlop];
    [self setNeedsDisplay];
}




-(void) showFastFlash{
    
    [self cleanup];
    [self startFastFlashing:BothEyes];
    [self setNeedsDisplay];
}

-(void) showPulse{
    
    [self cleanup];
    [self pulse:BothEyes];
    [self setNeedsDisplay];
}


-(void) showFlash9010{
    [self cleanup];
    [self start10_90Flashing:BothEyes];
    [self setNeedsDisplay];
}





-(void) showSlowFlash{
    [self cleanup];
    [self startSlowFlashing:BothEyes];
    [self setNeedsDisplay];
}



- (id) init{
    self = [super init];
    [self makeTheImages];
    return self;
}


-(void) cleanup{
    
    
    if ([self.timerON isValid]) {
        [self.timerON invalidate];
        self.timerON = nil;
    }
    if ([self.timerON2 isValid]) {
        [self.timerON2 invalidate];
        self.timerON2 = nil;
    }
    
    
    [self.leftImage.layer removeAllAnimations];
    [self.rightImage.layer removeAllAnimations];
    self.leftImage.alpha = 1;
    self.rightImage.alpha = 1;
    
    self.pulseFlag = NO;
    
    [self leftEye:YES rightEye:YES];
    [self setNeedsDisplay];
}



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeTheImages];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self makeTheImages];
    }
    return self;
}



-(void) makeTheImages{
    //create the UIImages
    
    CGRect leftFrame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    CGRect rightFrame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
    
    self.leftImage =  [[UIImageView alloc] initWithFrame:leftFrame];
    self.rightImage = [[UIImageView alloc] initWithFrame:rightFrame];
    
    [self.leftImage setBackgroundColor:[UIColor greenColor]];
    
    [self.rightImage setBackgroundColor:[UIColor greenColor]];
    
    [self addSubview:self.leftImage];
    [self addSubview:self.rightImage];
    
    slowFlashDuration = 0.6;
    fastFlashDuration = 0.2;
    my10_90Duration = 4;
}


-(void) setEyeColor:(UIColor*)color{
    [self.leftImage setBackgroundColor:color];
    [self.rightImage setBackgroundColor:color];
    [self setNeedsDisplay];
}


//set slow flash duration time
-(void) setSlowDuration:(float) duration {
    self.slowFlashDuration = duration;
}

//set fast flash duration time
-(void) setFastDuration:(float) duration {
    self.fastFlashDuration = duration;
}

//sets the overation duration time, eyes will still be on 10% off 90%
-(void) set10_90Duration:(float) duration {
    self.my10_90Duration = duration;
}

//use to turn eyes on/off without animation
-(void) leftEye:(BOOL) left rightEye:(BOOL) right {
    self.leftImage.hidden = !left;
    self.rightImage.hidden = !right;
}

//will flip-flop on off left and right
-(void) startFlipFlop {
    
    self.leftImage.hidden = YES;
    self.rightImage.hidden = NO;
    self.timerON = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(flipFlop) userInfo:nil repeats:YES];
}

-(void)flipFlop{
    self.leftImage.hidden = !self.leftImage.hidden;
    self.rightImage.hidden = !self.rightImage.hidden;
    [self.leftImage setNeedsDisplay];
    [self.rightImage setNeedsDisplay];
}


-(void) startSlowFlashing:(EyeType)eye {
    self.eyeToFlash = eye;
    self.timerON = [NSTimer scheduledTimerWithTimeInterval:slowFlashDuration target:self selector:@selector(switchOnOff) userInfo:nil repeats:YES];
}


-(void) startFastFlashing:(EyeType)eye {
    self.eyeToFlash = eye;
    self.timerON = [NSTimer scheduledTimerWithTimeInterval:fastFlashDuration target:self selector:@selector(switchOnOff) userInfo:nil repeats:YES];
}

-(void) switchOnOff{
    switch(eyeToFlash) {
        case LeftEye:
            self.leftImage.hidden = !self.leftImage.hidden;
            break;
            
        case RightEye:
            self.rightImage.hidden = !self.rightImage.hidden;
            break;
        default:
            self.rightImage.hidden = !self.rightImage.hidden;
            self.leftImage.hidden = !self.leftImage.hidden;
            break;
    }
}


//cycle through low to high slowly
-(void) pulse:(EyeType)eye {
    
    if(pulseFlag)
        return;
    
    pulseFlag = YES;
    
    self.eyeToFlash = eye;
    [self doPulse:1 theDelay:0];
}

-(void) doPulse:(float)dur theDelay:(float)del{
    
    
    [UIView animateWithDuration:dur
                          delay:del
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         //self.alpha = 0.0f;
                         
                         if(eyeToFlash == LeftEye)
                             self.leftImage.alpha = 0.0f;
                         
                         else if(eyeToFlash == RightEye)
                             self.rightImage.alpha = 0.0f;
                         
                         else {
                             self.leftImage.alpha = 0.0f;
                             self.rightImage.alpha = 0.0f;
                         }
                         
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}


//flash on for 10%, offfor 90%
-(void) start10_90Flashing:(EyeType)eye {
  
    if(eye == LeftEye)
        self.leftImage.hidden = YES;
    
    else if(eye == RightEye)
        self.rightImage.hidden = YES;
    
    else {
        self.leftImage.hidden = YES;
        self.rightImage.hidden = YES;
    }
    
    self.eyeToFlash = eye;
    self.timerON = [NSTimer scheduledTimerWithTimeInterval:self.my10_90Duration target:self selector:@selector(raiseDelayTimer) userInfo:nil repeats:YES];
}

-(void) raiseDelayTimer {
    
    if(eyeToFlash == LeftEye)
        self.leftImage.hidden = NO;
    
    else if(eyeToFlash == RightEye)
        self.rightImage.hidden = NO;
    
    else {
        self.leftImage.hidden = NO;
        self.rightImage.hidden = NO;
    }
    
    self.timerON2 = [NSTimer scheduledTimerWithTimeInterval:(self.my10_90Duration/11) target:self selector:@selector(endDelayTimer) userInfo:nil repeats:NO];
}

-(void) endDelayTimer {
    if(eyeToFlash == LeftEye)
        self.leftImage.hidden = YES;
    
    else if(eyeToFlash == RightEye)
        self.rightImage.hidden = YES;
    
    else {
        self.leftImage.hidden = YES;
        self.rightImage.hidden = YES;
    }
}





-(void) dealloc {
    self.timerON = nil;
    self.timerON2 = nil;
}

@end

