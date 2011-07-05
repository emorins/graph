//
//  GraphNode.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

/**
 * GraphNode
 */
@interface GraphNode : NSObject {
    @public
    NSMutableDictionary *adjacentNodes_;
    int                 id_;
    BOOL                isActive_;
}

/**
 * adjacentNodes
 */
@property (retain, readwrite) NSMutableDictionary *adjacentNodes;

/**
 * node id
 */
@property (assign, readwrite) int id;

/**
 * isActive
 */
@property (readwrite) BOOL isActive;

/**
 * 隣接ノードの追加
 * @param ノードID
 * @param コスト
 */
- (void)addAdjacentNode:(int)nodeId cost:(int)cost;

/**
 * getAdjacentNode
 * @param nodeId
 * @returns cost
 */
- (int)getAdjacentNode:(int)nodeId;

/**
 * removeAdjacentNode
 * @param nodeId
 */
- (void)removeAdjacentNode:(int)nodeId;

@end
