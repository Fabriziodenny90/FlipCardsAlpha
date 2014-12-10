//
//  MyLayout.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 12/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "MyLayout.h"

@interface MyLayout()

@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@end

@implementation MyLayout


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
    NSLog(@"Size, %f", [self collectionView].frame.size.width);
    CGFloat w = self.cellNum * 61;
    CGFloat h = 30;
    CGSize ccc = CGSizeMake(w, h);
    return ccc;
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    
    attributes.size = CGSizeMake(60, 60);
    attributes.center = CGPointMake(30 + 61*path.item,
                                    0);

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
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
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
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
      //  attributes.size = CGSizeMake(0, 0);
        attributes.center = CGPointMake(30 + 61*itemIndexPath.item,
                                        -50);
    }
    
    return attributes;
}

@end
