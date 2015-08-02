//
//  ServerManager.m
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "HotelSmall.h"
#import "HotelClass.h"

@interface ServerManager ()

@end


@implementation ServerManager

- (instancetype)initWithUrlString : (NSString*) urlString
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (instancetype) sharedManager {
    
    static ServerManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        sharedManager = [[ServerManager alloc] initWithUrlString:@""];
    });
    
    
    return sharedManager;
}


- (void) getHotelsArrayWithSuccess : (void(^)(NSMutableArray* array)) success
                        andFailture: (void(^)(NSError *error)) failture {
    
    
    
    NSString *requestString = @"https://dl.dropboxusercontent.com/u/109052005/1/0777.json";
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:requestString]];
    
    NSError *error;
    NSArray *arrayJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSMutableArray* mutableArray = [NSMutableArray new];
    
    for (NSDictionary *dict in arrayJSON)
    {
        HotelSmall *hotel = [[HotelSmall alloc] initWithResponse:dict];
        
        [mutableArray addObject: hotel];
    }
    
    success(mutableArray);
    
}



- (void) getHotelWithID : (NSString*) stringID
              andSuccess: (void(^)(HotelClass* hotel)) success
             andFailture: (void(^)(NSError *error)) failture {
    
    
    
    NSString *requestString = [@"https://dl.dropboxusercontent.com/u/109052005/1/" stringByAppendingString:stringID];
    requestString = [requestString stringByAppendingString:@".json"];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:requestString]];
    
    if (!data) {
        
        NSError *errorData = [NSError errorWithDomain:@"No DATA" code:121 userInfo:nil];
        failture(errorData);
    } else {
    
    NSError *error;
    NSDictionary *dictionaryJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (dictionaryJSON && !error) {
        
        HotelClass *hotel = [[HotelClass alloc] initWithResponse:dictionaryJSON];
        
        success(hotel);
    } else {
        
        failture(error);
    }
        
    }
}


@end
