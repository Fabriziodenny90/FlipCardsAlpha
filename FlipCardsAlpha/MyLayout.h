//
//  MyLayout.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 12/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLayout : UICollectionViewLayout

@property (nonatomic) int cellNum;

-(id)initWithNum:(int)num;

@end
