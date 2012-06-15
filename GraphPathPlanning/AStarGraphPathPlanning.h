//
//  AStarGraphPathPlanning.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "NavigationGraph.h"
#import "NavigationGraphNode.h"
#import "AStarGraphPathPlanningNode.h"


/**
 * NavigationGraphからA*アルゴリズムによる経路探索を行うクラス
 */
@interface AStarGraphPathPlanning : NSObject {
}

/**
 * A*アルゴリズムによる経路探索を行う
 * @param 探索対象となるナビゲーショングラフ
 * @param 始点ノードのID
 * @param 終点ノードのID
 * @returns 経路を表すノードIDの配列。到達できなかった場合はnilを返す
 */
+ (NSArray *)planning:(NavigationGraph *)graph start:(int)startNodeId goal:(int)goalNodeId;

@end
