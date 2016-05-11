//
//  MasterCell.h
//  CodingChallenge
//
//  Created by jason debottis on 5/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceProvider.h"
@interface MasterCell : UITableViewCell
@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UILabel *reviewNumberLabel;
@property (nonatomic, strong) UILabel *companyNameLabel;
@property (nonatomic, strong) UILabel *locationLabel;

- (void)CreateProvider:(ServiceProvider *)aProvider;

@end
