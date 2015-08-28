//
//  PersonCell.m
//  CoreDataMany
//
//  Created by Douglas Voss on 8/27/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = (PersonCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kPersonCellId];
    
    return self;
}

@end
