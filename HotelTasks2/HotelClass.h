//
//  HotelClass.h
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ServerObject.h"

@interface HotelClass : ServerObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) CGFloat stars;
@property (assign, nonatomic) double distance;
@property (strong, nonatomic) NSString *suites_availability;
@property (strong, nonatomic) NSString *photoString;
@property (assign, nonatomic) double lon, lat;

@end
