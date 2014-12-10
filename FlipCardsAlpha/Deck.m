//
//  Deck.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 05/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "Deck.h"
#define GOLD_RARITY_PROBABILITY_DIVIDER 6

@implementation Deck

-(id)init
{
    self = [super init];
    if(self){
        _cardsInDeck = [[NSMutableArray alloc] init];
    }
    return self;
}

-(Card *)drawRandomCard
{
    if([self.cardsInDeck count]){
        int positionOfCard = arc4random() % [self.cardsInDeck count];
        Card *cardToReturn = self.cardsInDeck[positionOfCard];
        [self.cardsInDeck removeObjectAtIndex:positionOfCard];
        return cardToReturn;
    } else {
        return nil;
    }
}

- (void)shuffle
{
    int i = 0;
    int deckSize = [self.cardsInDeck count];
    NSMutableArray *tmpDeck = [[NSMutableArray alloc] initWithCapacity:deckSize];
    for(i=0;i<deckSize;i++){
        if(self.cardsInDeck){
            [tmpDeck addObject:[self drawRandomCard]];
        }
    }
    [self.cardsInDeck removeAllObjects];
    [self.cardsInDeck addObjectsFromArray:[tmpDeck copy]];
}

-(void)addCardToDeck:(Card *)cardToAdd
{
    [self.cardsInDeck addObject:cardToAdd];
}

-(void)addCardsArrayToDeck:(NSArray *)cardsArrayToAdd
{
    [self.cardsInDeck addObjectsFromArray:cardsArrayToAdd];
}

@end
