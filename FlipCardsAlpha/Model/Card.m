//
//  Card.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 04/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card : NSObject

- (id)initWithDictionaryData:(NSDictionary *)dataDictionaryInput
{
	self = [self init];
	if (self) {
		_idNumber = (NSNumber *)[dataDictionaryInput valueForKey:@"idNumber"];
		_up = (NSNumber *)[dataDictionaryInput valueForKey:@"up"];
		_down = (NSNumber *)[dataDictionaryInput valueForKey:@"down"];
		_left = (NSNumber *)[dataDictionaryInput valueForKey:@"left"];
		_right = (NSNumber *)[dataDictionaryInput valueForKey:@"right"];
		_rarity = [dataDictionaryInput valueForKey:@"rarity"];
		_manaType = [dataDictionaryInput valueForKey:@"manaType"];
		
		NSString *path1 = [[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithFormat:@"Card%dRed", [_idNumber intValue]] ofType:@"png"]; //or .png?
		_redCardImage = [UIImage imageWithContentsOfFile:path1];
		NSString *path2 = [[NSBundle mainBundle] pathForResource:[[NSString alloc] initWithFormat:@"Card%dBlue", [_idNumber intValue]] ofType:@"png"]; //or .png?
		_blueCardImage = [UIImage imageWithContentsOfFile:path2];
	}
	return self;
}

+ (NSArray *)manaTypesAvailable
{
	NSArray *types = @[@"Fire",@"Water",@"Earth"];
	return types;
}

+ (NSArray *)rarityTypesAvailable
{
	NSArray *types = @[@"Common",@"Silver",@"Gold"];
	return types;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"CardId: %d", self.idNumber.intValue];
}

- (NSNumber *)upValue{
    return self.up;
}

- (NSNumber *)downValue{
    return self.down;
}

- (NSNumber *)leftValue{
    return self.left;
}

-(NSNumber *)rightValue{
    return self.right;
}

-(BOOL)isRed
{
    return self.isRed;
}

@end
