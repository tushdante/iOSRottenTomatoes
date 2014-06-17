//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/16/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MoviesViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>


@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (strong, nonatomic) IBOutlet UIScrollView *textScrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIView *movieView;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    
}


//Need to load the scroll view and set its content size before the view appears
//NOTE: Do not put this code in the viewDidLoad method since this will cause errors

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", self.currentMovie);
    
    
    self.titleLabel.text = self.currentMovie[@"title"];
    self.synopsisLabel.text = self.currentMovie[@"synopsis"];
    NSString *poster = self.currentMovie[@"posters"][@"original"];
    NSString *placeholder = self.currentMovie[@"posters"][@"thumbnail"];
    
    
    NSURL *url = [NSURL URLWithString:placeholder];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    
    
    [self.posterView setImageWithURL:[NSURL URLWithString:poster] placeholderImage:image];
    [self.synopsisLabel sizeToFit];
    [self scrollViewSettings];

    
    
}

- (void) scrollViewSettings {
    CGRect createFrame = self.movieView.frame;
    
    createFrame.size.height = self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height + 250;
    self.movieView.frame = createFrame;
    
    [self.textScrollView setContentSize:CGSizeMake(self.textScrollView.frame.size.width, self.movieView.frame.origin.y + self.movieView.frame.size.height - 200)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
