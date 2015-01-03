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

        SMSController.recipients = @[@"8136667795"];
        SMSController.body = @"whatsup";
        SMSController.messageComposeDelegate = self;

        
        [self presentViewController:SMSController animated:YES completion:nil];
        
        
    }else {
        NSLog(@"Can't send message");
    }
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled) NSLog(@"Message Cancelled");
    if (result == MessageComposeResultFailed) NSLog(@"Message Sending Failed");
    if (result == MessageComposeResultSent) NSLog(@"Message Sent! Yay!");
}

-(void) viewDidAppear:(BOOL)animated
{
    // Checking if UserNotifications (Alerts) are enabled by the user
    UIUserNotificationSettings *currentNotificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    // Display notification to the user to Enable User Notifications
    if (currentNotificationSettings.types == UIUserNotificationTypeNone) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Important"
               message:@"In order for you to receive reminders about your messages you need to allow this app to do so. Please go to Settings > Notifications > FutureText and allow notifications."
        preferredStyle:UIAlertControllerStyleAlert];
        
        // Dismiss action
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action) {}];
        [alert addAction:dismissAction];
        
        // Go to Settings action
        UIAlertAction *goToSettingsAction = [UIAlertAction actionWithTitle:@"Go To Settings Now"
             style:UIAlertActionStyleDefault
           handler:^(UIAlertAction *action) {
               
               // Opens settings
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
               
           }];
        [alert addAction:goToSettingsAction];

        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
