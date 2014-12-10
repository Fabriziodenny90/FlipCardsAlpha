//
//  MyLayout.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 12/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "MyLayoutTable.h"
#import "RandomGameViewControllerCollectionCardCell.h"


@interface MyLayoutTable()

@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@property (nonatomic, strong) NSMutableArray *reloadIndexPaths;
@property (nonatomic, strong) UICollectionView *myCV;
@end

@implementation MyLayoutTable


-(id)initWithNum:(int)num
{
    self = [self init];
    if (self) {
        self.cellNum=num;
    }
    return self;
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    attributes.size = CGSizeMake(60, 60);
    attributes.center = CGPointMake(path.item%4*66+43,
                                    path.item/4*66+45);
    
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellNum; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    self.reloadIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionReload)
        {
            [self.reloadIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
    self.reloadIndexPaths = nil;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.reloadIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        // Configure attributes ...
        if(![itemIndexPath compare:self.updatingCell]){
            attributes.alpha = 0.0;
            attributes.center = CGPointMake(itemIndexPath.item%4*66+35+50,
                                            itemIndexPath.item/4*66+45);
        }
    }
    
    return attributes;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    
    if ([self.reloadIndexPaths containsObject:itemIndexPath])
    {

        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];

        // Configure attributes ...
        if(![itemIndexPath compare:self.updatingCell]){
        attributes.alpha = 0.0;
        attributes.center = CGPointMake(itemIndexPath.item%4*66+35-50,
                                        itemIndexPath.item/4*66+45);
        }
        
        RandomGameViewControllerCollectionCardCell *myCell = (RandomGameViewControllerCollectionCardCell *)[self.collectionView cellForItemAtIndexPath:itemIndexPath];
        [myCell.myCardView setTemplate];

    }
    
    return attributes;
}

@end
