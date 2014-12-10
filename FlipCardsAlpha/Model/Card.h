//
//  Card.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 04/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (readonly, nonatomic) NSNumber *idNumber;
@property (readonly, nonatomic) NSNumber *down;
@property (readonly, nonatomic) NSNumber *left;
@property (readonly, nonatomic) NSNumber *right;
@property (readonly, nonatomic) NSNumber *up;
//@property (readonly, nonatomic) NSString *playerId; the card shouldn't care about which player belongs to
@property (readonly, nonatomic) NSString *rarity;
@property (readonly, nonatomic) NSString *manaType;
//easy graphic implementation using entire cards png images.
//flip the card using selected7notselected is an option for two faces cards.
@property (strong, nonatomic) UIImage *blueCardImage;
@property (strong, nonatomic) UIImage *redCardImage;

+ (NSArray *)manaTypesAvailable;
+ (NSArray *)rarityTypesAvailable;

- (id)initWithDictionaryData:(NSDictionary *)dataDictionaryInput;
- (NSNumber *)upValue;
- (NSNumber *)downValue;
- (NSNumber *)rightValue;
- (NSNumber *)leftValue;
- (BOOL) isRed;


@end
