//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/6/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "MBProgressHUD.h"
#import <AFNetworking/UIKit+AFNetworking.h>


@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSArray *movies;

@end

@implementation MoviesViewController

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
    self.title = @"Rotten Tomatoes App";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    [self apiCall];
    

    self.tableView.rowHeight = 120;
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
    
    MovieTableViewCell *movieCell = (MovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (movieCell == nil) {
        NSLog(@"inside nil condition");
        movieCell = [[MovieTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    movieCell.movieTitleLabel.text = movie[@"title"];
    movieCell.synopsisLabel.text = movie[@"synopsis"];
    NSString *poster = movie[@"posters"][@"thumbnail"];
    
    //Using AFNetworking to load image asynchronously
    [movieCell.posterView setImageWithURL:[NSURL URLWithString:poster]];
    
    return movieCell;
}


- (void) apiCall {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        self.movies = object[@"movies"];
        [self.tableView reloadData];
    }];
    
}


@end
