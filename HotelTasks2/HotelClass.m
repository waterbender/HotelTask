
//
//  HotelClass.m
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "HotelClass.h"

@implementation HotelClass

- (instancetype)initWithResponse : (NSDictionary*) dictionary
{
    self = [super initWithResponse:dictionary];
    if (self) {
        
        if (dictionary) {
            
        self.id = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"address"];
        self.stars = [[dictionary objectForKey:@"stars"] floatValue];
        self.distance = [[dictionary objectForKey:@"distance"] doubleValue];
        self.suites_availability = [dictionary objectForKey:@"suites_availability"];
        self.stars = [[dictionary objectForKey:@"stars"] floatValue];
        self.distance = [[dictionary objectForKey:@"distance"] doubleValue];
        self.suites_availability = [dictionary objectForKey:@"suites_availability"];
        self.photoString = [dictionary objectForKey:@"image"];
        self.lat = [[dictionary objectForKey:@"lat"] doubleValue];
        self.lon = [[dictionary objectForKey:@"lon"] doubleValue];
        
        } else {
            
            return nil;
        }
    }
    return self;
}

@end
