//
//  Game.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "CardsLibrary.h"

@interface Game : NSObject

@property (strong,nonatomic) NSMutableArray *cardsOnTable;
@property (strong,nonatomic) NSMutableArray *colorsOnTable;
@property (strong,nonatomic) Player *redPlayer;
@property (strong,nonatomic) Player *bluePlayer;
@property (strong,nonatomic) CardsLibrary *myCardsLibrary;

-(BOOL)addCard:(int)positionInHandOfPlayedCard atPositionOnTable:(NSNumber *)x byPlayer:(Player *)whoPlayed;
-(NSString *)checkWinningId;

+(NSNumber *)abovePositionWRTLocation:(NSNumber *)x;
+(NSNumber *)belowPositionWRTLocation:(NSNumber *)x;
+(NSNumber *)leftPositionWRTLocation:(NSNumber *)x;
+(NSNumber *)rightPositionWRTLocation:(NSNumber *)x;

@end
