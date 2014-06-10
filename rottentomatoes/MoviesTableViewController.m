//
//  MoviesTableViewController.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/9/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "MBProgressHUD.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "Reachability.h"
#import "MovieTableViewCell.h"

@interface MoviesTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;

@end

@implementation MoviesTableViewController
bool refreshValue;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Rotten Tomatoes App";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self apiCall];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(refreshData:forState:) forControlEvents:UIControlEventValueChanged];
    refreshValue = YES;
    self.tableView.rowHeight = 140;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell for row at index path %d", indexPath.row);
    
    NSDictionary *movie = self.movies[indexPath.row];
    static NSString *CellIdentifier = @"MovieTableViewCell";
    
    MovieTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    movieCell.movieTitleLabel.text = movie[@"title"];
    movieCell.synopsisLabel.text = movie[@"synopsis"];
    NSString *poster = movie[@"posters"][@"thumbnail"];
    
    //Using AFNetworking to load image asynchronously
    [movieCell.posterView setImageWithURL:[NSURL URLWithString:poster]];
    
    return movieCell;
}




#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    MovieViewController *detailViewController = [[MovieViewController alloc] initWithNibName:@"MovieViewController" bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    NSDictionary *currentMovie = self.movies[indexPath.row];

//    MovieViewController *movie = self.movies[indexPath.row];
    detailViewController.currentMovie = currentMovie;


    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


- (void) apiCall {
    bool connection = [self checkConnection];
    if (connection) {
        
        NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
            self.movies = object[@"movies"];
            [self.tableView reloadData];
        }];
    }
    
}

//Pull to refresh helper functions

- (void) refreshData:(id)sender forState:(UIControlState)state {
    [self apiCall];
    [self.refreshControl endRefreshing];
}

-(BOOL)canBecomeFirstResponder
{
    return !refreshValue;
}

-(void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


//Helper functions for network error page

- (BOOL) connectionHelper {
    
    Reachability *r = [Reachability reachabilityWithHostName:@"rottentomatoes.com"];
    
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
    
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}

-(BOOL) checkConnection {
	//Make sure we have internet connectivity
	if([self connectionHelper] != YES) {
//        [self networkErrorControl:NO];
		return NO;
	} else {
//        [self networkErrorControl:YES];
		return YES;
	}
}


@end

