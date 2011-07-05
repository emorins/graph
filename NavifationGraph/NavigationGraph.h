//
//  NavigationGraph.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "Graph.h"
#import "NavigationGraphNode.h"


/**
 * NavigationGraph
 */
@interface NavigationGraph : Graph {
    @public
    int                 spacePartitioningInterval_;
    NSMutableDictionary *spacePartitioningNodes_;
}

/**
 * spacePartitioningNodes
 */
@property (retain, readwrite) NSMutableDictionary *spacePartitioningNodes;

/**
 * spacePartitioningInterval
 */
@property int spacePartitioningInterval;


#pragma mark -
#pragma mark static method
/**
 * CreateNavigationGraphWithFloodFill
 * @param startPoint
 * @param receiver
 * @param selector
 * @param diagonal
 * @returns NavigationGraph
 */
+ (NavigationGraph *)CreateNavigationGraphWithFloodFill:(CGPoint)startPoint
   receiver:(id)receiver
   selector:(SEL)selecter
   diagonal:(int)diagonal;

/**
 * searchNavigationGraphNode
 */
+ (NavigationGraphNode *)searchNavigationGraphNode:(NSArray *)stack point:(CGPoint)point;

/**
 * getDiagonal
 */
+ (int)getDiagonal;


#pragma mark -
#pragma mark node
/**
 * createNode
 * @returns NavigationGraphNode
 */
- (NavigationGraphNode *)createNode;

/**
 * getNode
 * @param nodeId
 * @returns NavigationGraphNode
 */
- (NavigationGraphNode *)getNode:(int)nodeId;

/**
 * addNode
 * @param NavigationGraphNode
 */
- (void)addNode:(NavigationGraphNode *)node;

/**
 * removeNode
 * @param NavigationGraphNode
 */
- (void)removeNode:(NavigationGraphNode *)node;

/**
 * searchWithPoint
 * @param point
 * @returns node
 */
- (id)searchWithPoint:(CGPoint)point;

/**
 * nearestNode
 * @param point
 * @returns node
 */
- (NavigationGraphNode *)nearestNode:(CGPoint)point;

@end
