//
//  Hotel.h
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ServerObject.h"

@interface HotelSmall : ServerObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) CGFloat stars;
@property (assign, nonatomic) double distance;
@property (strong, nonatomic) NSString *suites_availability;
@property (assign, nonatomic) NSInteger freeNumbers;


@end
