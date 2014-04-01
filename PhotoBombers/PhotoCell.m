//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by Matthew Voracek on 3/27/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [UIImageView new];
        self.imageView.image = [UIImage imageNamed:@"st vincent.jpg"];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
