//
//  Deck.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 05/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (readonly,nonatomic) NSMutableArray *cardsInDeck; //of Cards

- (Card *)drawRandomCard;
- (void)shuffle;
- (void)addCardToDeck:(Card *)cardToAdd;
- (void)addCardsArrayToDeck:(NSArray *)cardsArrayToAdd;

@end
