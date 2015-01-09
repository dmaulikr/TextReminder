//
//  testClass.m
//  FutureText
//
//  Created by Serguei Vinnitskii on 1/8/15.
//  Copyright (c) 2015 Kartoshka. All rights reserved.
//

#import "testClass.h"

@implementation testClass

-(void) doSomething
{
    self.openInteger = self.openInteger * 2;
}
-(void) printSomething
{
    NSLog(@"%d", self.openInteger);
}

+(void) classMethod: (NSString *)string
{
    NSLog(@"%@", string);
}

// Or

+(int) square: (int) integer
{
    return integer * integer;
}

@end
