//
//  CardsLibrary.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 04/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "CardsLibrary.h"

@implementation CardsLibrary

#define APPROXIMATE_CARDSNUMBER 10
#define GOLD_RARITY_PROBABILITY_DIVIDER 6
#define SILVER_RARITY_PROBABILITY_DIVIDER 3

-(id)initWithPlistNamed:(NSString *)resourceName
{
	self = [self init];
	if (self) {
		NSMutableArray *tmpCommonList = [[NSMutableArray alloc] initWithCapacity:APPROXIMATE_CARDSNUMBER];
		NSMutableArray *tmpSilverList = [[NSMutableArray alloc] initWithCapacity:APPROXIMATE_CARDSNUMBER];
		NSMutableArray *tmpGoldList = [[NSMutableArray alloc] initWithCapacity:APPROXIMATE_CARDSNUMBER];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"plist"];
		NSDictionary *cardsInfoDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
		NSDictionary *singleCardInfo;
		NSEnumerator *enumerator = [cardsInfoDictionary objectEnumerator];
		while (singleCardInfo = [enumerator nextObject]) {
			Card *tmpCard = [[Card alloc] initWithDictionaryData:singleCardInfo];
            if([tmpCard.rarity isEqualToString:@"Common"]){
                [tmpCommonList addObject:tmpCard];
            } else if ([tmpCard.rarity isEqualToString:@"Silver"]) {
                [tmpSilverList addObject:tmpCard];
            } else if ([tmpCard.rarity isEqualToString:@"Gold"]){
                [tmpGoldList addObject:tmpCard];
            }
		}
        _CommonCardsInLibrary = [tmpCommonList copy];
        _SilverCardsInLibrary = [tmpSilverList copy];
        _GoldCardsInLibrary = [tmpGoldList copy];
    }
    return self;
}

-(Deck *)generateRandomDeckWithSize:(NSNumber *)size
{
    int intsize = [size intValue];
    
    if (intsize<18) {
        NSLog(@"Deck with less than 18 cards not allowed.");
        return nil;
    }
    
    Deck *myRandomDeck = [[Deck alloc] init];
    
    int i = 0;
    
    int goldNumber = round(intsize/GOLD_RARITY_PROBABILITY_DIVIDER);
    for (i=0; i<goldNumber; i++) {
        int casualGoldPosition = arc4random() % [self.GoldCardsInLibrary count];
        [myRandomDeck addCardToDeck:self.GoldCardsInLibrary[casualGoldPosition]];
    }
    
    int silverNumber = round(intsize/SILVER_RARITY_PROBABILITY_DIVIDER);
    for (i=0; i<silverNumber; i++) {
        int casualSilverPosition = arc4random() % [self.SilverCardsInLibrary count];
        [myRandomDeck addCardToDeck:self.SilverCardsInLibrary[casualSilverPosition]];
    }
    
    int commonNumber = intsize - goldNumber - silverNumber;
    for (i=0; i<commonNumber; i++) {
        int casualCommonPosition = arc4random() % [self.CommonCardsInLibrary count];
        [myRandomDeck addCardToDeck:self.CommonCardsInLibrary[casualCommonPosition]];
    }
    return myRandomDeck;
}

@end
