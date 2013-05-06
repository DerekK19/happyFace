//
//  HFFriendsLayout.m
//  happyFace
//
//  Created by Derek Knight on 4/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFFriendsLayout.h"

static NSString * const HFFriendsLayoutCellKind = @"friendCell";

@interface HFFriendsLayout ()

@property (nonatomic) NSDictionary *layoutInfo;

@end

@implementation HFFriendsLayout

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    _itemInsets = UIEdgeInsetsMake(22.f, 22.f, 13.f, 22.f);
    _itemSize = CGSizeMake(175.f, 175.f);
    _interItemSpacingY = 60.f;
    _numberOfColumns = 5;
}

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    NSInteger firstRow = 0;
    for (NSInteger section = 0; section < sectionCount; section++)
    {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSInteger sectionRows = (itemCount + _numberOfColumns - 1) / _numberOfColumns;
        for (NSInteger item = 0; item < itemCount; item++)
        {
            indexPath = [NSIndexPath indexPathForItem:item
                                            inSection:section];
            NSIndexPath *imageIndexPath = [NSIndexPath indexPathForItem:item % _numberOfColumns
                                                              inSection:firstRow + (item / _numberOfColumns)];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForFriendAtIndexPath:imageIndexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
        firstRow += sectionRows;
    }
    
    newLayoutInfo[HFFriendsLayoutCellKind] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}

#pragma mark - Private

- (CGRect)frameForFriendAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.section ;
    NSInteger column = indexPath.row;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.width);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[HFFriendsLayoutCellKind][indexPath];
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = 0;
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++)
    {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSInteger sectionRows = (itemCount + _numberOfColumns - 1) / _numberOfColumns;
        rowCount += sectionRows;
    }

    CGFloat height = self.itemInsets.top +
    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end
