//
//  Player.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Player : NSObject

@property (strong,nonatomic) NSMutableArray *hand;
@property (strong,nonatomic) Deck *deck;
@property (strong,nonatomic) NSString *playerId;

@end
