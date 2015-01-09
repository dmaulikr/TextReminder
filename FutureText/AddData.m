//
//  AddData.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 1/8/15.
//  Copyright (c) 2015 Kartoshka. All rights reserved.
//

#import "AddData.h"

@implementation AddData

// Add data to NSUserDefaults
+(void) addDataUserDefaults: (NSDate *)date phoneNumber: (NSString *)number textMessage: (NSString *)textMessage
{
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"array"]];
    
    // retreve current data form defaults into an array
    NSLog(@"Old array: %@", array);
    // OK to this point
    
    NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:date, @"date", number, @"number", textMessage, @"message", nil];
    [array addObject:newDictionary];
    NSLog(@"New array: %@", array);
    
    // Remove old object
    [defaults removeObjectForKey:@"array"];
    
    // Add new updated object with new data
    [defaults setObject:array forKey:@"array"];
    
    [defaults synchronize];
    
}

// calculate number of rows
+(int) calculateNumberOfRows
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    array = [defaults objectForKey:@"array"];
    
    return [array count];
}

// Retreve data from NSUserDefaults
+(NSMutableArray *) retreveDataUserDefaults
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"array"]];
    
    return array;
}

@end
