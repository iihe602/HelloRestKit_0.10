//
//  Location.h
//  HelloRestKit 5
//
//  Created by wangyongqi on 1/8/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

//example data

//"location": {
//    "address": "10500 De Anza Blvd",
//    "lat": 37.329438,
//    "lng": -122.03083,
//    "distance": 96,
//    "postalCode": "95014",
//    "city": "Cupertino",
//    "state": "CA",
//    "country": "United States",
//    "cc": "US"
//}

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic) float lat;
@property (nonatomic) float lng;
@property (nonatomic) int distance;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *cc;

@end
