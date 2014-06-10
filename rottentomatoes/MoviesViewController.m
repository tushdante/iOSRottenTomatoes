//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/6/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MoviesViewController.h"
#import "MBProgressHUD.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "Reachability.h"


@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;

@end

@implementation MoviesViewController
bool refreshValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self networkErrorControl:YES];

    self.title = @"Rotten Tomatoes App";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    [self networkErrorControl:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self apiCall];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    //Pull to refresh code
    

    
//        self.refreshControl = [[UIRefreshControl alloc] init];
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
//
//		[self.refreshControl addTarget:self action:@selector(refreshData:forState:) forControlEvents:UIControlEventValueChanged];
//		refreshValue = YES;
//	
    
    

    self.tableView.rowHeight = 140;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
//    [self.refreshControl endRefreshing];
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
        [self networkErrorControl:NO];
		return NO;
	} else {
        [self networkErrorControl:YES];
		return YES;
	}
}



-(void) networkErrorControl: (BOOL)status {
    if (status) {
        //resize to 0,0
        self.networkErrorView.hidden = YES;
        CGRect newFrame = self.networkErrorView.frame;
        
        newFrame.size.height = 0;
        [self.networkErrorView setFrame:newFrame];
    }else{
        //resize to 0, 50
        self.networkErrorView.hidden = NO;
        CGRect newFrame = self.networkErrorView.frame;
        
        newFrame.size.height = 45;
        [self.networkErrorView setFrame:newFrame];
    }
}


@end
