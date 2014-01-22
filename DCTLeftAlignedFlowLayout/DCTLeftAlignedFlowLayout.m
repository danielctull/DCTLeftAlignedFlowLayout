//
//  DCTLeftAlignedFlowLayout.m
//  DCTLeftAlignedFlowLayout
//
//  Created by Daniel Tull on 22.01.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "DCTLeftAlignedFlowLayout.h"

@implementation DCTLeftAlignedFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

	NSArray *attributesToReturn = [super layoutAttributesForElementsInRect:rect];

    for (UICollectionViewLayoutAttributes *attributes in attributesToReturn)
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            NSIndexPath *indexPath = attributes.indexPath;
			UICollectionViewLayoutAttributes *correctedAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            attributes.frame = correctedAttributes.frame;
        }

    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frame = attributes.frame;

	CGRect previousFrame = CGRectZero;
	if (indexPath.item > 0) {
		NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
		UICollectionViewLayoutAttributes *previousAttributes = [self layoutAttributesForItemAtIndexPath:previousIndexPath];
		previousFrame = previousAttributes.frame;
	}

	BOOL newline = frame.origin.y >= previousFrame.origin.y + previousFrame.size.height;

	if (newline)
		frame.origin.x = self.sectionInset.left;
	else
		frame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;

    attributes.frame = frame;
    return attributes;
}

@end
