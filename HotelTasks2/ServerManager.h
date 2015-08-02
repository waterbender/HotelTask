//
//  ServerManager.h
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HotelClass;

@interface ServerManager : NSObject


+ (instancetype) sharedManager;
- (instancetype)initWithUrlString : (NSString*) urlString;
- (void) getHotelsArrayWithSuccess : (void(^)(NSMutableArray* array)) success
                        andFailture: (void(^)(NSError *error)) failture;
- (void) getHotelWithID : (NSString*) stringID
              andSuccess: (void(^)(HotelClass* hotel)) success
             andFailture: (void(^)(NSError *error)) failture;

@end
