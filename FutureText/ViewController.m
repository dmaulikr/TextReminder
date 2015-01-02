//
//  ViewController.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 12/29/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()  <MFMessageComposeViewControllerDelegate>

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSMS:(UIButton *)sender {
    MFMessageComposeViewController *SMSController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText]) {

//        SMSController.recipients = @[@"8132709947"];
        SMSController.body = @"whatsup";
        SMSController.messageComposeDelegate = self;

        
        [self presentViewController:SMSController animated:YES completion:nil];
        
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }else {
        NSLog(@"Can't send message");
    }
    
    
    
}
@end
