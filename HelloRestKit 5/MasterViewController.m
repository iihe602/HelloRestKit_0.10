//
//  MasterViewController.m
//  HelloRestKit 5
//
//  Created by wangyongqi on 1/6/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#define kCLIENTID "AIQF31DJE4AOG4TEORSJX1QJFQHMQKMNT5UO5M5DPS0KTB4W"
#define kCLIENTSECRET "WFJY4HK4DXMDAZDX3PGUMBYOIKYSJVRFJYLONPGMZRSKIQQG"

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <RestKit/RestKit.h>
#import <RestKit/RKObjectMapping.h>

#import "LoggerClient.h"

#import "Venue.h"
#import "Stats.h"

#import "VenueCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    
}
@end

@implementation MasterViewController

@synthesize data;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    
    RKURL *baseURL = [RKURL URLWithBaseURLString:@"https://api.Foursquare.com/v2"];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.client.baseURL = baseURL;
    
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping mapKeyPathsToAttributes:@"name", @"name", nil];
    [objectManager.mappingProvider setMapping:venueMapping forKeyPath:@"response.venues"];
    
    //location
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping mapKeyPathsToAttributes:@"addressƒ", @"addressƒ",
         @"lat", @"lat",
         @"lng", @"lng",
         @"distance", @"distance",
         @"postalCode", @"postalCode",
         @"city", @"city",
         @"state", @"state",
         @"country", @"country",
         @"cc", @"cc",
     nil];
    [objectManager.mappingProvider setMapping:locationMapping forKeyPath:@"location"];

    [venueMapping mapRelationship:@"location" withMapping:locationMapping];

    // stats
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping mapKeyPathsToAttributes:
         @"checkinsCount",@"checkinsCount",
         @"usersCount",@"usersCount",
         @"tipCount",@"tipCount",
     nil];
    [objectManager.mappingProvider setMapping:statsMapping forKeyPath:@"stats"];
    
    [venueMapping mapRelationship:@"stats" withMapping:statsMapping];
    
    [self sendRequest];
    

    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)sendRequest
{
    NSString *latLon = @"37.33,-122.03";
    NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];
    
    NSDictionary *queryParams;
    //https://api.Foursquare.com/v2/venues/search?client_secret=WFJY4HK4DXMDAZDX3PGUMBYOIKYSJVRFJYLONPGMZRSKIQQG&client_id=AIQF31DJE4AOG4TEORSJX1QJFQHMQKMNT5UO5M5DPS0KTB4W&query=coffee&v=20120602&ll=37.33%2C-122.03
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", clientSecret, @"client_secret", @"coffee", @"query", @"20120602", @"v", nil];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    RKURL *URL = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/venues/search" queryParameters:queryParams];
    NSLog(@"url: %@\n resourcePath: %@\n query: %@", [URL description], [URL resourcePath], [URL query]);
    [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [URL resourcePath], [URL query]] delegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self.tableView setRowHeight:33.0f];
    }
    else
    {
        [self.tableView setRowHeight: 57.0f];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Venue *venue = [data objectAtIndex:indexPath.row];
    cell.nameLabel.text = [venue name];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%dm", venue.location.distance];
    cell.checkinsLabel.text = [NSString stringWithFormat:@"%d checkins", venue.stats.checkinsCount];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma make - RKObjectLoaderDelegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    //NSLog(@"response code: %d, %@", [response statusCode], [response bodyAsString]);
    LogMessage(@"aaaa", 1, @"response code: %d, body: %@", [response statusCode], [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
//    NSLog(@"objects[%d], %@", [objects count],  NSStringFromClass([objects[0] class]));
    data = objects;
    
    [self.tableView reloadData];
}

@end
