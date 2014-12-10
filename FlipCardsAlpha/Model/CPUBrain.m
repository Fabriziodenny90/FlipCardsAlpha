//
//  CPUBrain.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 07/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "CPUBrain.h"

@implementation CPUBrain

#define MIN_SCORE -99
#define MULTIPLY_WINNING_FACTOR 10
#define COMBO_MULTIPLY_FACTOR 20
#define WILL_LOSE_FACTOR_NEGATIVE 1 //default 2

+(NSDictionary *)generateMoveWithModel:(Game *)myModelGame byPlayer:(Player *)player
{
    int positionsTotal = [myModelGame.cardsOnTable count];
    int score= MIN_SCORE;
    NSNumber *positionOnTable=@(0);
    NSNumber *cardInHand=@(0);
    int i = 0;
    for(i=0;i<positionsTotal;i++){
        if([myModelGame.cardsOnTable[i] isKindOfClass:[NSString class]]){
            if([myModelGame.cardsOnTable[i] isEqualToString:@"Empty"]){
                
                //check various cards in position
                int y = 0;
                for(y=0;y<[player.hand count];y++){
                    int sum = 0;
                    int win = 0;
                    Card *actualCardInHandChecked = player.hand[y];
                    
                    
                    //check above
                    NSNumber *abovePositionNSNumber = [[myModelGame class] abovePositionWRTLocation:[[NSNumber alloc] initWithInt:i]];
                    if(abovePositionNSNumber){
                        int abovePosition = [abovePositionNSNumber intValue];
                        if([myModelGame.cardsOnTable[abovePosition] isKindOfClass:[NSString class]]){
                            sum+=([[actualCardInHandChecked upValue] intValue]-2);
                        }
                        if([myModelGame.cardsOnTable[abovePosition] isKindOfClass:[Card class]]){
                            Card *aboveCard = myModelGame.cardsOnTable[abovePosition];
                            if(([myModelGame.colorsOnTable[abovePosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Red"]) || (![myModelGame.colorsOnTable[abovePosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Blue"])){
                                //My card adj
                                sum-=([[actualCardInHandChecked upValue] intValue]+2);
                            } else {
                                if([aboveCard downValue]>=[actualCardInHandChecked upValue]){
                                    //Will Lose!
                                    sum = sum - WILL_LOSE_FACTOR_NEGATIVE*[[actualCardInHandChecked upValue] intValue] + [[aboveCard downValue] intValue];
                                } else {
                                    //Will win
                                    sum = sum - ([[actualCardInHandChecked upValue] intValue]) + (MULTIPLY_WINNING_FACTOR*[[aboveCard downValue] intValue]) + 2;
                                    win++;
                                }
                            }
                        }
                        
                    } else sum-=([[actualCardInHandChecked upValue] intValue]+2);
                    
                    
                    //check below
                    NSNumber *belowPositionNSNumber = [[myModelGame class] belowPositionWRTLocation:[[NSNumber alloc] initWithInt:i]];
                    if(belowPositionNSNumber){
                        int belowPosition = [belowPositionNSNumber intValue];
                        if([myModelGame.cardsOnTable[belowPosition] isKindOfClass:[NSString class]]){
                            sum+=([[actualCardInHandChecked downValue] intValue]-2);
                        }
                        if([myModelGame.cardsOnTable[belowPosition] isKindOfClass:[Card class]]){
                            Card *belowCard = myModelGame.cardsOnTable[belowPosition];
                            if(([myModelGame.colorsOnTable[belowPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Red"]) || (![myModelGame.colorsOnTable[belowPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Blue"])){
                                sum-=([[actualCardInHandChecked downValue] intValue]+2);
                            } else {
                                if([belowCard upValue]>=[actualCardInHandChecked downValue]){
                                    sum = sum - WILL_LOSE_FACTOR_NEGATIVE*[[actualCardInHandChecked downValue] intValue] + [[belowCard upValue] intValue];
                                } else {
                                    sum = sum - [[actualCardInHandChecked downValue] intValue] + MULTIPLY_WINNING_FACTOR*[[belowCard upValue] intValue] + 2;
                                    win++;
                                }
                            }
                        }
                        
                    } else sum-=([[actualCardInHandChecked downValue] intValue]+2);
                    
                    
                    //check left
                    NSNumber *leftPositionNSNumber = [[myModelGame class] leftPositionWRTLocation:[[NSNumber alloc] initWithInt:i]];
                    if(leftPositionNSNumber){
                        int leftPosition = [leftPositionNSNumber intValue];
                        if([myModelGame.cardsOnTable[leftPosition] isKindOfClass:[NSString class]]){
                            sum+=([[actualCardInHandChecked leftValue] intValue]-2);
                        }
                        if([myModelGame.cardsOnTable[leftPosition] isKindOfClass:[Card class]]){
                            Card *leftCard = myModelGame.cardsOnTable[leftPosition];
                            if(([myModelGame.colorsOnTable[leftPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Red"]) || (![myModelGame.colorsOnTable[leftPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Blue"])){
                                sum-=([[actualCardInHandChecked leftValue] intValue]+2);
                            } else {
                                if([leftCard rightValue]>=[actualCardInHandChecked leftValue]){
                                    sum = sum - WILL_LOSE_FACTOR_NEGATIVE*[[actualCardInHandChecked leftValue] intValue] + [[leftCard rightValue] intValue];
                                } else {
                                    sum = sum - [[actualCardInHandChecked leftValue] intValue] + MULTIPLY_WINNING_FACTOR*[[leftCard rightValue] intValue] + 2;
                                    win++;
                                }
                            }
                        }
                        
                    } else sum-=([[actualCardInHandChecked leftValue] intValue]+2);
                    
                    
                    
                    //check right
                    NSNumber *rightPositionNSNumber = [[myModelGame class] rightPositionWRTLocation:[[NSNumber alloc] initWithInt:i]];
                    if(rightPositionNSNumber){
                        int rightPosition = [rightPositionNSNumber intValue];
                        if([myModelGame.cardsOnTable[rightPosition] isKindOfClass:[NSString class]]){
                            sum+=([[actualCardInHandChecked rightValue] intValue]-2);
                        }
                        if([myModelGame.cardsOnTable[rightPosition] isKindOfClass:[Card class]]){
                            Card *rightCard = myModelGame.cardsOnTable[rightPosition];
                            if(([myModelGame.colorsOnTable[rightPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Red"]) || (![myModelGame.colorsOnTable[rightPosition] isEqualToString:@"Red"] && [player.playerId isEqualToString:@"Blue"])){
                                sum-=([[actualCardInHandChecked rightValue] intValue]+2);
                            } else {
                                if([rightCard leftValue]>=[actualCardInHandChecked rightValue]){
                                    sum = sum - WILL_LOSE_FACTOR_NEGATIVE*[[actualCardInHandChecked rightValue] intValue] + [[rightCard leftValue] intValue];
                                } else {
                                    sum = sum - [[actualCardInHandChecked rightValue] intValue] + MULTIPLY_WINNING_FACTOR*[[rightCard leftValue] intValue] + 2;
                                    win++;
                                }
                            }
                        }
                        
                    } else sum-=([[actualCardInHandChecked rightValue] intValue]+2);
                    
                    sum = sum + COMBO_MULTIPLY_FACTOR*win;
                    //compare with Score
                    if (sum>score){
                        score = sum;
                        cardInHand=@(y);
                        positionOnTable=@(i);
                    }
                }
            }
        }
    }
    
    NSDictionary *move=@{@"Position": positionOnTable, @"CardInHand": cardInHand};
    return move;
}



@end
