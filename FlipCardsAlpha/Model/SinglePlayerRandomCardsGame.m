//
//  SinglePlayerRandomCardsGame.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "SinglePlayerRandomCardsGame.h"

@implementation SinglePlayerRandomCardsGame

#define DECK_SIZE 24
#define HAND_SIZE 8

-(id)init
{
    self = [super init];
    if(self){
        int i = 0;
        self.redPlayer = [[Player alloc]init];
        self.redPlayer.playerId = @"Red";
        self.redPlayer.deck = [self.myCardsLibrary generateRandomDeckWithSize:@(DECK_SIZE)];
        for(i=0;i<HAND_SIZE;i++){
            [self.redPlayer.hand addObject:[self.redPlayer.deck drawRandomCard]];
        }
        self.bluePlayer = [[Player alloc]init];
        self.bluePlayer.playerId = @"Blue";
        self.bluePlayer.deck = [self.myCardsLibrary generateRandomDeckWithSize:@(DECK_SIZE)];
        for(i=0;i<HAND_SIZE;i++){
            [self.bluePlayer.hand addObject:[self.bluePlayer.deck drawRandomCard]];
        }
    }
    return self;
}

@end
