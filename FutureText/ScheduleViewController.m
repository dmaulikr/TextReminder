//
//  ViewController.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 12/29/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import "ScheduleViewController.h"
#import "AddData.h"
#import <ECPhoneNumberFormatter.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ScheduleViewController.h"

@interface ScheduleViewController ()  < ABPeoplePickerNavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *pickedDate;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextLabel;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Set Miminum Date to display by UIDatePicker so users can't schedule for the date in the past
    self.pickedDate.minimumDate = [NSDate date];
    self.messageTextLabel.delegate = self;
    self.phoneNumberLabel.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(UIButton *)sender {
    
    // Checking if UserNotifications (Alerts) are enabled by the user
    UIUserNotificationSettings *currentNotificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    // Display notification to the user to Enable User Notifications
    if (!(currentNotificationSettings.types & UIUserNotificationTypeAlert)) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't schedule alert"
                                                                       message:@"Please to to Seetings > Notifications and enable ALERTS and SOUNDS"
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
    
    // Display notification to the user to Enable Sounds
    if (!(currentNotificationSettings.types & UIUserNotificationTypeSound)) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Can't schedule alert"
                                                                       message:@"Please to to Seetings > Notifications and enable SOUNDS"
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

    // If Sound+Alerts are available -> chedule notifications
    if ((currentNotificationSettings.types & UIUserNotificationTypeSound) && (currentNotificationSettings.types & UIUserNotificationTypeAlert))
        {
            //Schedule notification
            [self scheduleLocalNotification:self.pickedDate.date];
            
            //Add entry to NSUserDefaults
            [AddData addDataUserDefaults:self.pickedDate.date phoneNumber:self.phoneNumberLabel.text textMessage:self.messageTextLabel.text];
        }
}

-(void) scheduleLocalNotification: (NSDate *)date
{
    // Create LocalNotification and specify it's parameters
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = 0;
    localNotification.alertBody = @"Scheduled Message Alert!";
    localNotification.alertAction = @"Slide to send message"; // doesn't do anything
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Displays alert to the user about successful schedule of their notification
    UIAlertController *successfulSchedule = [UIAlertController alertControllerWithTitle:@"Note:"
       message:@"Your reminder has been successfully scheduled."
    preferredStyle:UIAlertControllerStyleAlert];
    
    // Dismiss action
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
            style:UIAlertActionStyleDefault
          handler:^(UIAlertAction * action) {
              
              // Dismisses current ViewController and returns to UITableViewController
              [self.navigationController popViewControllerAnimated:YES];
          
          }];
    [successfulSchedule addAction:dismissAction];
    
    [self presentViewController:successfulSchedule animated:YES completion:^{}];
}

- (IBAction)pickContactButton:(UIButton *)sender
{
    ABPeoplePickerNavigationController *contactsNavController = [[ABPeoplePickerNavigationController alloc] init];
    contactsNavController.peoplePickerDelegate = self;
    
    // Prefents ABPeoplePickerNavigationController to display anything else but phone numbers!
    contactsNavController.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    [self presentViewController:contactsNavController animated:YES completion:nil];
}

// Delegate of ABPeoplePickerNavigationControllerDelegate - CASE: CANCEL
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    // Just dismiss the ABPeoplePickerNavigationController
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Delegate of ABPeoplePickerNavigationControllerDelegate - CASE: CHOSEN CONTACT
-(void) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    // Lets copy the picked contacts' phone number to our label
    ABMultiValueRef phoneNumber = ABRecordCopyValue(person, property);
    self.phoneNumberLabel.text = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneNumber, ABMultiValueGetIndexForIdentifier(phoneNumber, identifier));
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Delegate of UITextView (to dismiss keyboard)
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

// Delegate of UITextField to format phone number
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    ECPhoneNumberFormatter *formating = [[ECPhoneNumberFormatter alloc] init];
    NSString *proposedNewString = [formating stringForObjectValue:textField.text];
    textField.text = proposedNewString;
    
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
        ECPhoneNumberFormatter *formatter = [[ECPhoneNumberFormatter alloc] init];
        self.phoneNumberLabel.text = [formatter stringForObjectValue:textField.text];

    return YES;
}

@end
