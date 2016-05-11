//
//  ServiceProvider.h
//  CodingChallenge
//
//  Created by jason debottis on 5/9/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoordinateModel;

@interface ServiceProvider : NSObject
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *overallRating;
@property (nonatomic) NSInteger reviewCount;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;



@end
