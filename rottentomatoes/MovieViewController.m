//
//  MovieViewController.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/9/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MovieViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>


@interface MovieViewController ()
@end

@implementation MovieViewController

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
    

//    self.fullTextLabel.text = currentMovie[@"title"];
    self.titleLabel.text = self.currentMovie[@"title"];
    self.fullTextView.text = self.currentMovie[@"synopsis"];
    NSString *poster = self.currentMovie[@"posters"][@"thumbnail"];
    
    [self.bigPosterView setImageWithURL:[NSURL URLWithString:poster]];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
