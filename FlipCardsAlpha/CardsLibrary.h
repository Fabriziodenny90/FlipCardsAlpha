//
//  CardsLibrary.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 04/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardsLibrary : NSObject

@property (readonly,nonatomic) NSArray *CommonCardsInLibrary;
@property (readonly,nonatomic) NSArray *SilverCardsInLibrary;
@property (readonly,nonatomic) NSArray *GoldCardsInLibrary;

- (Deck *)generateRandomDeckWithSize:(NSNumber *)size;
- (id)initWithPlistNamed:(NSString *)resourceName;


@end
