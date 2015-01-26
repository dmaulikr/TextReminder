//
//  ScheduledItemsTVC.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 1/8/15.
//  Copyright (c) 2015 Kartoshka. All rights reserved.
//

#import "ScheduledItemsTVC.h"
#import "AddData.h"
#import "DetailViewController.h"

@interface ScheduledItemsTVC () <UITableViewDelegate>

@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) UIView *tutorialBackgoundView;

@end

@implementation ScheduledItemsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    // First Launch Tutorial Options
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasPerformedFirstLauch"]==NO) {
        // On first launch, this block will execute
        
        // Create a semi-transparent dark background
        self.tutorialBackgoundView = [[UIView alloc] init];
        self.tutorialBackgoundView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        [self.tutorialBackgoundView setFrame:self.view.frame];
        
        UIImage *tutorialImage = [UIImage imageNamed:@"tutorial_image"];
        
        UIImageView *overlayView = [[UIImageView alloc] initWithImage:tutorialImage];
        
        [overlayView setFrame:CGRectMake(0, 0, self.view.frame.size.width, tutorialImage.size.height)];
        [self.tutorialBackgoundView addSubview:overlayView];
        
        [overlayView setContentMode:UIViewContentModeTopRight];
        //        [overlayView setContentMode:UIViewContentModeScaleAspectFit];
        
        // Your scroll view or table view would be a subview of this view
        [self.view addSubview:self.tutorialBackgoundView];
        [self.view bringSubviewToFront:self.tutorialBackgoundView];
        
        // Set the "hasPerformedFirstLaunch" to NO so this block won't execute again
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasPerformedFirstLauch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        [self.tutorialBackgoundView removeFromSuperview];
    }
    
    [self.tableView reloadData];
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [AddData calculateNumberOfRows];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    // Configure the cell...
    
    // Setting Date & Time format to display in the cell
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    self.currentDate = [NSDate date];


    // Assigning and retreving dates
    NSDate *objectDate = [[[AddData retreveDataUserDefaults] objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    // Checking the Due Date to displayed messages that are due in RED
    // Creating strings out of our NSUserDefaults data
    
    if ([objectDate compare: self.currentDate]==NSOrderedAscending) {
        // Display date in Red + add "DUE" at the end
        NSString *title = [dateFormatter stringFromDate: objectDate];
        cell.textLabel.textColor = [UIColor colorWithRed:244/255.0f green:117/255.0f blue:251/255.0f alpha:1.0f];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - Due", title];
    }
    else {
        // Display date just in black
        NSString *title = [dateFormatter stringFromDate: objectDate];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = title;
    }
    
   // Assign subtitle text
    NSString *subTitle = [NSString stringWithFormat:@"To number: %@", [[[AddData retreveDataUserDefaults] objectAtIndex:indexPath.row] objectForKey:@"number"]];
    cell.detailTextLabel.text = subTitle;
    
    return cell;
}

// This method is here only because UI in iPad changes background color of the cell back to white
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor colorWithRed:118/255.0f green:109/255.0f blue:131/255.0f alpha:1.0f]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Deleting rows
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [AddData deleteNotificationWithRowNumber:(int)indexPath.row];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"detailVewControllerSegue"])
    {
        // Get reference to the destination view controller
        DetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        // Passing NSIndexPath to DetailViewController
        [vc setRowNumber:path.row];
    }
}

@end
