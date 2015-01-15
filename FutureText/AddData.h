//
//  AddData.h
//  FutureText
//
//  Created by Serguei Vinnitskii on 1/8/15.
//  Copyright (c) 2015 Kartoshka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddData : NSObject

+(void) addDataUserDefaults: (NSDate *)date phoneNumber: (NSString *)number textMessage: (NSString *)textMessage;
+(int) calculateNumberOfRows;
+(NSMutableArray *) retreveDataUserDefaults;
+(void) deleteNotificationWithRowNumber: (int) row;
+(void) deleteNotificationWithDate: (NSDate *) date;

@end
