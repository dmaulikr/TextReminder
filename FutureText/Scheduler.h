//
//  Scheduler.h
//  FutureText
//
//  Created by Serguei Vinnitskii on 12/29/14.
//  Copyright (c) 2014 Kartoshka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface Scheduler : NSObject
@property (strong, nonatomic) NSString *messageBody;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSDate *date;

@end
