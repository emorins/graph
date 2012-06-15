//
//  AStarGraphPathPlanningNode.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "NavigationGraphNode.h"


/**
 * 探索用ノード
 */
@interface AStarGraphPathPlanningNode : NSObject {
    @public
    NavigationGraphNode        *node_;
    AStarGraphPathPlanningNode *parentPlanningNode_;
    int                        gs_;
    int                        hs_;
}

/**
 * ノードの実体
 */
@property (retain, readwrite) NavigationGraphNode *node;

/**
 * 親AStarGraphPathPlanningNode
 */
@property (retain, readwrite) AStarGraphPathPlanningNode *parentPlanningNode;

/**
 * 始点ノードからノードnまでの推定最小コスト
 */
@property int gs;

/**
 * ノードnから終点ノードまでの推定最小コスト
 */
@property int hs;

/**
 * AStarGraphPathPlanningNodeを作成する
 * @param ノード
 * @param 親ノード
 * @returns AStarGraphPathPlanningNode
 */
+ (AStarGraphPathPlanningNode *)node:(NavigationGraphNode *)node parentPlanningNode:(AStarGraphPathPlanningNode *)parentPlanningNode;

/**
 * f*(n)を求める
 * @returns f*(n)
 */
- (int)fs;

@end
