//
//  MovieTableViewCell.h
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/8/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviesViewController.h"

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
