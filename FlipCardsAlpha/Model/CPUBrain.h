//
//  CPUBrain.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 07/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface CPUBrain : NSObject

+(NSDictionary *)generateMoveWithModel:(Game *)myModelGame byPlayer:(Player *)player;

@end
