//
//  MovieViewController.h
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/9/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bigPosterView;

@property (weak, nonatomic) IBOutlet UITextView *fullTextView;
@property (strong, nonatomic) NSDictionary *currentMovie;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
