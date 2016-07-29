//
//  ViewController.m
//  YQSpeedometer
//
//  Created by Wang on 16/7/29.
//  Copyright © 2016年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "YQSpeedometer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YQSpeedometer *speedometer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.speedometer.gradientColors = @[[UIColor redColor],[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor],[UIColor purpleColor]];
    self.speedometer.speed = 25;
    
}


- (IBAction)slideAction:(UISlider *)sender {
    self.speedometer.speed = sender.value;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
