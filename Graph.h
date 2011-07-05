//
//  Graph.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "GraphNode.h"


/**
 * Graph
 */
@interface Graph : NSObject {
    @protected
    int                 nodeIdCount_;
    @public
    NSMutableDictionary *nodes_;
}

/**
 * nodes
 */
@property (retain, readwrite) NSMutableDictionary *nodes;


#pragma mark -
#pragma mark ノード
/**
 * createNode
 * @returns GraphNode
 */
- (GraphNode *)createNode;

/**
 * getNode
 * @param nodeId
 * @returns GraphNode
 */
- (GraphNode *)getNode:(int)nodeId;

/**
 * addNode
 * @param GraphNode
 */
- (void)addNode:(GraphNode *)nodeId;

/**
 * removeNode
 * @param GraphNode
 */
- (void)removeNode:(GraphNode *)nodeId;

/**
 * nodeCount
 * @returns int
 */
- (int)nodeCount;

/**
 * activeNodes
 * @returns NSArray
 */
-(NSArray *)activeNodes;

@end
