//
//  CardView.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setCardView:(Card *)cardToDisplay isRed:(BOOL)isRed
{
    if(isRed){
        self.image=cardToDisplay.redCardImage;
    } else {
        self.image=cardToDisplay.blueCardImage;
    }
}

-(void)setTemplate
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Template" ofType:@"png"];
    self.image = [UIImage imageWithContentsOfFile:path];
    
}

-(void)setSelected
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RoundSelector2" ofType:@"png"];
    UIImageView *selectorView = [[UIImageView alloc]initWithFrame:self.frame];
    selectorView.image = [[UIImage alloc]initWithContentsOfFile:path];
    [self addSubview:selectorView];
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
