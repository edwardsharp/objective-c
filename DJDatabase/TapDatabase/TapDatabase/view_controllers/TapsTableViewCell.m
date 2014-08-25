//
//  TapsTableViewCell.m
//  TapDatabase
//
//  Created by edward on 4/24/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import "TapsTableViewCell.h"

@implementation TapsTableViewCell

@synthesize tapsTableCellLabel = _tapsTableCellLabel;
@synthesize tapsTableCellImage = _tapsTableCellImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier: reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
                
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
