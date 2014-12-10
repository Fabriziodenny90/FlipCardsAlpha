//
//  Game.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "Game.h"

@implementation Game

#define PLACES_ON_TABLE 16
#define ROW_LENGHT 4

-(id)init
{
    self = [super self];
    if(self){
        int i = 0;
        self.cardsOnTable = [[NSMutableArray alloc] initWithCapacity:PLACES_ON_TABLE];
        for(i=0;i<PLACES_ON_TABLE;i++){
            self.cardsOnTable[i] = @"Empty";
        }
        self.colorsOnTable = [[NSMutableArray alloc] initWithCapacity:PLACES_ON_TABLE];
        for(i=0;i<PLACES_ON_TABLE;i++){
            self.colorsOnTable[i] = @"Empty";
        }
        self.myCardsLibrary = [[CardsLibrary alloc]initWithPlistNamed:@"cardsLibrary"];
    }
    return self;
    
}

-(BOOL)addCard:(int)positionInHandOfPlayedCard atPositionOnTable:(NSNumber *)x byPlayer:(Player *)whoPlayed
{
    int arrayPosition = [x intValue];
    if([self.cardsOnTable[arrayPosition] isKindOfClass:[NSString class]]){
        if([self.cardsOnTable[arrayPosition] isEqualToString:@"Empty"]){
            self.cardsOnTable[arrayPosition] = whoPlayed.hand[positionInHandOfPlayedCard];
            self.colorsOnTable[arrayPosition] = whoPlayed.playerId;
            [self removeFromHandCard:positionInHandOfPlayedCard byPlayer:whoPlayed];
            [self checkActionAtPosition:x byPlayer:whoPlayed];
            return YES;
        }
    }
    return NO;
}

-(NSNumber *)checkActionAtPosition:(NSNumber *)x byPlayer:(Player *)whoPlayed
{
    int countFlips=0;
    if([self checkAbove:x byPlayer:whoPlayed]) countFlips++;
    if([self checkDown:x byPlayer:whoPlayed]) countFlips++;
    if([self checkRight:x byPlayer:whoPlayed]) countFlips++;
    if([self checkLeft:x byPlayer:whoPlayed]) countFlips++;
    return @(countFlips);
}



+(NSNumber *)abovePositionWRTLocation:(NSNumber *)x
{
    int arrayPosition = [x intValue];
    if(arrayPosition<ROW_LENGHT) return nil;
    int abovePosition = arrayPosition-ROW_LENGHT;
    return @(abovePosition);
}



-(BOOL)checkAbove:(NSNumber *)x byPlayer:(Player *)whoPlayed{
    NSNumber *abovePositionNSNumber = [[self class] abovePositionWRTLocation:x];
    if(abovePositionNSNumber){
        int abovePosition = [abovePositionNSNumber intValue];
        int arrayPosition = [x intValue];
        if([self.cardsOnTable[abovePosition] isKindOfClass:[NSString class]]) return NO;
        if([self.cardsOnTable[abovePosition] isKindOfClass:[Card class]]){
            if([[self.cardsOnTable[abovePosition] downValue] intValue] < [[self.cardsOnTable[arrayPosition] upValue] intValue]){
                self.colorsOnTable[abovePosition] = whoPlayed.playerId;
                return YES;
            }
        }
    }
    return NO;
}

+(NSNumber *)belowPositionWRTLocation:(NSNumber *)x
{
    int arrayPosition = [x intValue];
    if(arrayPosition>=(PLACES_ON_TABLE-ROW_LENGHT)) return nil;
    int belowPosition = arrayPosition+ROW_LENGHT;
    return @(belowPosition);
}

-(BOOL)checkDown:(NSNumber *)x byPlayer:(Player *)whoPlayed{
    NSNumber *belowPositionNSNumber = [[self class] belowPositionWRTLocation:x];
    if(belowPositionNSNumber){
        int belowPosition = [belowPositionNSNumber intValue];
        int arrayPosition = [x intValue];
        if([self.cardsOnTable[belowPosition] isKindOfClass:[NSString class]]) return NO;
        if([self.cardsOnTable[belowPosition] isKindOfClass:[Card class]]){
            if([[self.cardsOnTable[belowPosition] upValue] intValue] < [[self.cardsOnTable[arrayPosition] downValue] intValue]){
                self.colorsOnTable[belowPosition] = whoPlayed.playerId;
                return YES;
            }
        }
    }
    return NO;
}


    
+(NSNumber *)leftPositionWRTLocation:(NSNumber *)x
{
    int arrayPosition = [x intValue];
    if(arrayPosition==0 || (arrayPosition%ROW_LENGHT)==0) return nil;
    int leftPosition = arrayPosition-1;
    return @(leftPosition);
}

-(BOOL)checkLeft:(NSNumber *)x byPlayer:(Player *)whoPlayed{
    NSNumber *leftPositionNSNumber = [[self class] leftPositionWRTLocation:x];
    if(leftPositionNSNumber){
        int leftPosition = [leftPositionNSNumber intValue];
        int arrayPosition = [x intValue];
        if([self.cardsOnTable[leftPosition] isKindOfClass:[NSString class]]) return NO;
        if([self.cardsOnTable[leftPosition] isKindOfClass:[Card class]]){
            if([[self.cardsOnTable[leftPosition] rightValue] intValue] < [[self.cardsOnTable[arrayPosition] leftValue] intValue]){
                self.colorsOnTable[leftPosition] = whoPlayed.playerId;
                return YES;
            }
        }
    }
    return NO;
}


+(NSNumber *)rightPositionWRTLocation:(NSNumber *)x
{
    int arrayPosition = [x intValue];
    if(((arrayPosition+1)%ROW_LENGHT)==0) return nil;
    int rightPosition = arrayPosition+1;
    return @(rightPosition);
}

-(BOOL)checkRight:(NSNumber *)x byPlayer:(Player *)whoPlayed{
    NSNumber *rightPositionNSNumber = [[self class] rightPositionWRTLocation:x];
    if(rightPositionNSNumber){
        int rightPosition = [rightPositionNSNumber intValue];
        int arrayPosition = [x intValue];
        if([self.cardsOnTable[rightPosition] isKindOfClass:[NSString class]]) return NO;
        if([self.cardsOnTable[rightPosition] isKindOfClass:[Card class]]){
            if([[self.cardsOnTable[rightPosition] leftValue] intValue] < [[self.cardsOnTable[arrayPosition] rightValue] intValue]){
                self.colorsOnTable[rightPosition] = whoPlayed.playerId;
                return YES;
            }
        }
    }
    return NO;
}

-(void)removeFromHandCard:(int)positionInHandOfPlayedCard byPlayer:(Player *)whoPlayed
{
    [whoPlayed.hand removeObjectAtIndex:positionInHandOfPlayedCard];
}

-(NSString *)checkWinningId
{
    NSArray *colorsToCheck = [self.colorsOnTable copy];
    int blue = 0;
    int red = 0;
    int i = 0;
    for (i=0;i<[colorsToCheck count];i++){
        if([colorsToCheck[i] isEqualToString:@"Red"]){
            red++;
        } else if ([colorsToCheck[i] isEqualToString:@"Blue"]){
            blue++;
        }
    }
    if(blue>red){
        return @"Blue";
    } else if (red>blue){
        return @"Red";
    } else return @"Tie";
}

@end
