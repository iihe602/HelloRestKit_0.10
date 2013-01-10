//
//  MasterViewController.h
//  HelloRestKit 5
//
//  Created by wangyongqi on 1/6/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RKObjectLoader.h>

@interface MasterViewController : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) NSArray *data;

@end
