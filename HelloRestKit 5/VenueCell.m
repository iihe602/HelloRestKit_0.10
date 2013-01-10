//
//  VenueCell.m
//  HelloRestKit 5
//
//  Created by wangyongqi on 1/8/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import "VenueCell.h"

@implementation VenueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];

//    CGRect distanceFrame = self.distanceLabel.frame;
//    CGRect checkinsFrame = self.checkinsLabel.frame;

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        //横屏
        self.distanceTrailingSpace.constant = 120;
    }
    else
    {
        //竖屏
        self.distanceTrailingSpace.constant = 20;
    }
}

@end
