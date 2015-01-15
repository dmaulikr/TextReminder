//
//  DetailViewController.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 1/9/15.
//  Copyright (c) 2015 Kartoshka. All rights reserved.
//

#import "DetailViewController.h"
#import "AddData.h"
#import <MessageUI/MessageUI.h>

@interface DetailViewController () <MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageText;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) NSDate *date;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Retreve data from NSUserDefaults
    NSArray *array = [NSArray arrayWithArray:[AddData retreveDataUserDefaults]];
    NSDictionary *dictionary = [array objectAtIndex:self.indexPath.row];
    
    // Setting Date & Time format to display in the cell
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    self.phoneNumberLabel.text = [dictionary objectForKey:@"number"];
    self.messageText.text = [dictionary objectForKey:@"message"];
    self.dateLabel.text = [dateFormatter stringFromDate:[dictionary objectForKey:@"date"]];
    self.date = [dictionary objectForKey:@"date"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessageButton:(UIButton *)sender
{
    MFMessageComposeViewController *SMSController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText]) {
        
        SMSController.recipients = @[self.phoneNumberLabel.text];
        SMSController.body = self.messageText.text;
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
}

- (IBAction)deleteButton:(UIButton *)sender {
    
    [AddData deleteNotificationWithDate: self.date];
    
    // Dismisses current ViewController and returns to UITableViewController
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
