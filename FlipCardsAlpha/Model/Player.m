//
//  Player.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "Player.h"

@implementation Player

-(NSMutableArray *)hand
{
    if(!_hand) _hand=[[NSMutableArray alloc]init];
    return _hand;
}


@end
