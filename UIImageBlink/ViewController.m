//
//  ViewController.m
//  UIImageBlink
//
//    Copyright (c) 2015 Studio 609. All rights reserved.
//

#import "ViewController.h"
#import "UIImageBlink.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageBlink *myBlinker;
- (IBAction)alternatePress:(id)sender;
- (IBAction)pulsePress:(id)sender;
- (IBAction)flash90_10Press:(id)sender;
- (IBAction)fastFlash:(id)sender;

- (IBAction)leftOnlyPress:(id)sender;
- (IBAction)rightOnlyPress:(id)sender;

- (IBAction)slowFlash:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //set the blink color
    [self.myBlinker setEyeColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)alternatePress:(id)sender {
    [self.myBlinker showFlashAlternate];
}


- (IBAction)pulsePress:(id)sender {
    [self.myBlinker showPulse];
}


- (IBAction)flash90_10Press:(id)sender {
    [self.myBlinker showFlash9010];
}

- (IBAction)fastFlash:(id)sender {
    [self.myBlinker showFastFlash];
}





- (IBAction)leftOnlyPress:(id)sender {
    [self.myBlinker showFlashLeft];
}

- (IBAction)rightOnlyPress:(id)sender {
    [self.myBlinker showFlashRight];
}

- (IBAction)slowFlash:(id)sender {
    [self.myBlinker showSlowFlash];
}
@end
