//
//  MyLayoutTable.h
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 13/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLayoutTable : UICollectionViewLayout

@property (nonatomic) int cellNum;
@property (strong,nonatomic) NSIndexPath *updatingCell;

-(id)initWithNum:(int)num;

@end
