//
//  CardView.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIImageView

-(void)setCardView:(Card *)cardToDisplay isRed:(BOOL)isRed;

-(void)setTemplate;
-(void)setSelected;

@end
