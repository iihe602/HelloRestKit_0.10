//
//  VenueCell.h
//  HelloRestKit 5
//
//  Created by wangyongqi on 1/8/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel *checkinsLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *distanceTrailingSpace;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *checkinsBottomSpace;

@end
