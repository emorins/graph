//
//  AStarGraphPathPlanning.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "AStarGraphPathPlanning.h"


@implementation AStarGraphPathPlanning



#pragma mark -
#pragma mark 初期化メソッド
- (id)init {
    if ((self = [super init])) {
    }
    return (self);
}


#pragma mark -
#pragma mark メモリマネージャ
- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark staticメソッド
+ (NSArray *)planning:(NavigationGraph *)graph start:(int)startNodeId goal:(int)goalNodeId {	
    //[nodeId:AStarGraphPathPlanningNode]
    NSMutableDictionary *openList  = [NSMutableDictionary dictionary];
    NSMutableDictionary *closeList = [NSMutableDictionary dictionary];

    //終点ノードを一旦activeに
    BOOL goalIsActive = [[graph getNode:goalNodeId] isActive];
    [[graph getNode:goalNodeId] setIsActive:YES];
    
    //開始ノード
    AStarGraphPathPlanningNode *planningNode = [AStarGraphPathPlanningNode node:[graph nodeById:startNodeId] parentPlanningNode:nil];

    //始点からの推定最小コストを計算
    int                        gs     = 0;
    AStarGraphPathPlanningNode *node_ = planningNode;

    while (YES) {
        if ([node_ parentPlanningNode] == nil) {
            break;
        }
        gs   += [[[node_ parentPlanningNode] node] getAdjacentNode:[[node_ node] id]];
        node_ = [node_ parentPlanningNode];
    }
    [planningNode setGs:gs];

    //終点までの推定最小コストを計算
    CGPoint nowPoint  = [[graph nodeById:startNodeId] position];
    CGPoint goalPoint = [[graph nodeById:goalNodeId] position];
    [planningNode setHs:abs(goalPoint.x - nowPoint.x) + abs(goalPoint.y - nowPoint.y)];

    //開始ノードをopenListにpush
    [openList setObject:planningNode forKey:[[NSNumber numberWithUnsignedInt:[[planningNode node] id]] stringValue]];

    //探索開始
    AStarGraphPathPlanningNode *nowNode = nil;
    NSMutableArray             *pathNodes = [NSMutableArray array];
    while (YES) {
        if ([openList count] == 0) {
            //行き止まりになっていて終点まで到達できない
            pathNodes = nil;
            break;
        }
        //openListから最もf*(n)の低いノードを取り出す
        int fs = 0;
        for (id key in openList) {
            if (fs == 0 || fs > [[openList objectForKey:key] fs]) {
                nowNode = [openList objectForKey:key];
                fs      = [nowNode fs];
            }
        }
        //終点のノードなら探索完了
        if ([[nowNode node] id] == goalNodeId) {
            //親ノードを辿ってパスを格納
            while (nowNode != nil) {
                [pathNodes addObject:[[NSNumber numberWithUnsignedInt:[[nowNode node] id]] stringValue]];
                nowNode = [nowNode parentPlanningNode];
            }
            break;
        }
        //openListからcloseListに移動
        [openList removeObjectForKey:[[NSNumber numberWithUnsignedInt:[[nowNode node] id]] stringValue]];
        [closeList setObject:nowNode forKey:[[NSNumber numberWithUnsignedInt:[[nowNode node] id]] stringValue]];

        //隣接ノードを探索
        for (id key in [[nowNode node] adjacentNodes]) {
            NavigationGraphNode *adjacentNode = [graph nodeById:[key intValue]];
            if ([openList objectForKey:[[NSNumber numberWithUnsignedInt:[adjacentNode id]] stringValue]] == nil &&
                [closeList objectForKey:[[NSNumber numberWithUnsignedInt:[adjacentNode id]] stringValue]] == nil &&
                [adjacentNode isActive] == YES) {
                //planningNode
                AStarGraphPathPlanningNode *planningNode = [AStarGraphPathPlanningNode node:adjacentNode parentPlanningNode:nowNode];

                //始点からの推定最小コストを計算
                int                        gs     = 0;
                AStarGraphPathPlanningNode *node_ = planningNode;

                while (YES) {
                    if ([node_ parentPlanningNode] == nil) {
                        break;
                    }
                    gs   += [[[node_ parentPlanningNode] node] getAdjacentNode:[[node_ node] id]];
                    node_ = [node_ parentPlanningNode];
                }
                [planningNode setGs:gs];

                //終点までの推定最小コストを計算
                CGPoint nowPoint  = [[planningNode node] position];
                CGPoint goalPoint = [[graph nodeById:goalNodeId] position];
                [planningNode setHs:abs(goalPoint.x - nowPoint.x) + abs(goalPoint.y - nowPoint.y)];

                //開始ノードをopenListにpush
                [openList setObject:planningNode forKey:[[NSNumber numberWithUnsignedInt:[[planningNode node] id]] stringValue]];
            }
        }
    }
    //終点ノードの状態をもとに戻す
    [[graph getNode:goalNodeId] setIsActive:goalIsActive];
    
    return ((NSArray *)pathNodes);
}

@end
