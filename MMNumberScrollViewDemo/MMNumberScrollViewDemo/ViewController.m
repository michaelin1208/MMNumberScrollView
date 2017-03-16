//
//  ViewController.m
//  MMNumberScrollViewDemo
//
//  Created by Michaelin on 2017/3/16.
//  Copyright © 2017年 Michaelin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    MMNumberScrollViewManager *numberScrollViewManager;
    UIButton *rollingButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    numberScrollViewManager = [[MMNumberScrollViewManager alloc] initWithFrame:CGRectMake(10, 20, 40, 80)];
    numberScrollViewManager.delegate = self;
    [self.view addSubview:numberScrollViewManager];
    
    rollingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rollingButton.frame = CGRectMake(10, self.view.frame.size.height - 100, self.view.frame.size.width - 20, 90);
    [rollingButton setTitle:@"Rolling Numbers" forState:UIControlStateNormal];
    [rollingButton addTarget:self action:@selector(rollingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rollingButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rollingButtonClicked:(id)sender {
//    rollingButton.userInteractionEnabled = NO;
    int start = arc4random() / 1000;
    int end = arc4random() / 1000;
    while (end <= start) {
        end = arc4random() / 1000;
    }
    numberScrollViewManager.speedDuration = 0.5;
    NSLog(@"start %d end %d", start, end);
    [numberScrollViewManager removeAllNumberScrollViews];
    [numberScrollViewManager increaseNumberFrom:start to:end];
}

#pragma mark - MMNumberScrollViewManagerDelegate 
- (void)numberScrollViewManagerFinishedIncreasing:(MMNumberScrollViewManager *)manager {
//    rollingButton.userInteractionEnabled = YES;
}

@end
