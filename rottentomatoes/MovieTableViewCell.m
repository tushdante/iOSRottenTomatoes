//
//  MovieTableViewCell.m
//  rottentomatoes
//
//  Created by Tushar Bhushan on 6/8/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
