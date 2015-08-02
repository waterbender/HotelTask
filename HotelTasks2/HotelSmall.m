//
//  Hotel.m
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "HotelSmall.h"

@implementation HotelSmall

- (instancetype)initWithResponse : (NSDictionary*) dictionary
{
    self = [super initWithResponse:dictionary];
    if (self) {
        
        
        self.id = [[dictionary objectForKey:@"id"] stringValue];
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"address"];
        self.stars = [[dictionary objectForKey:@"stars"] floatValue];
        self.distance = [[dictionary objectForKey:@"distance"] doubleValue];
        self.suites_availability = [dictionary objectForKey:@"suites_availability"];
        NSArray *array = [self.suites_availability componentsSeparatedByString:@":"];
        self.freeNumbers = [array count];
        
    }
    return self;
}

@end
