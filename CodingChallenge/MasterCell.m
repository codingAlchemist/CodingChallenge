//
//  MasterCell.m
//  CodingChallenge
//
//  Created by jason debottis on 5/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

#import "MasterCell.h"

@implementation MasterCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.ratingLabel = [UILabel new];
    self.reviewNumberLabel = [UILabel new];
    self.companyNameLabel = [UILabel new];
    self.locationLabel = [UILabel new];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.ratingLabel.layer.cornerRadius = 12;
    self.ratingLabel.layer.masksToBounds = YES;

}
- (void)SetConstraints:(UIView *)parent children:(NSDictionary *)children format:(NSString *)format{
    for (UIView *child in children.allValues) {
        child.translatesAutoresizingMaskIntoConstraints = false;
    }
    [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                   options:0
                                                                   metrics:NULL
                                                                     views:children]];
}
- (void)CreateProvider:(ServiceProvider *)aProvider{
    [self formatRatingsLabel:aProvider.overallRating];

    self.reviewNumberLabel.text = [NSString stringWithFormat:@"%lu Recent Reviews",aProvider.reviewCount];
    self.reviewNumberLabel.font = [UIFont systemFontOfSize:13];

    self.companyNameLabel.text = aProvider.name;
    self.companyNameLabel.font = [UIFont fontWithName:@"Baskerville-SemiBold" size:16];
    self.companyNameLabel.numberOfLines = 2;

    self.locationLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    self.locationLabel.font = [UIFont fontWithName:@"Cochin-Bold" size:13];
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@ %@",aProvider.city, aProvider.state, aProvider.postalCode];
    
    [self.contentView addSubview:self.ratingLabel];
    [self.contentView addSubview:self.reviewNumberLabel];
    [self.contentView addSubview:self.companyNameLabel];
    [self.contentView addSubview:self.locationLabel];
    
    NSDictionary *childViews = @{@"rating":self.ratingLabel,
                                 @"reviews":self.reviewNumberLabel,
                                 @"company":self.companyNameLabel,
                                 @"location":self.locationLabel};
    
    [self SetConstraints:self.contentView children:childViews format:@"H:|-[rating(==25)]-[reviews]-|"];
    [self SetConstraints:self.contentView children:childViews format:@"H:|-(==40)-[company]-|"];
    [self SetConstraints:self.contentView children:childViews format:@"H:|-(==40)-[location]-|"];
    [self SetConstraints:self.contentView children:childViews format:@"V:|-[reviews(==20)][company(==40)]-[location(==25)]-|"];
    [self SetConstraints:self.contentView children:childViews format:@"V:|-[rating(==25)]-|"];
    
}


- (void)formatRatingsLabel:(NSString *)rating{
    self.ratingLabel.textAlignment = NSTextAlignmentCenter;
    self.ratingLabel.font = [UIFont boldSystemFontOfSize:13];
    self.ratingLabel.text = rating;
    
    if ([rating isEqualToString:@"A"]) {
        self.ratingLabel.backgroundColor = [UIColor greenColor];
    }else if ([rating isEqualToString:@"B"]) {
        self.ratingLabel.backgroundColor = [UIColor yellowColor];
        
    }else if ([rating isEqualToString:@"C"]) {
        self.ratingLabel.backgroundColor = [UIColor orangeColor];
    }else if ([rating isEqualToString:@"D"]) {
        self.ratingLabel.backgroundColor = [UIColor redColor];
    }
}

@end
