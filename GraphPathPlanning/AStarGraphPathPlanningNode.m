//
//  AStarGraphPathPlanningNode.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "AStarGraphPathPlanningNode.h"


@implementation AStarGraphPathPlanningNode

@synthesize node               = node_,
            parentPlanningNode = parentPlanningNode_,
            gs                 = gs_,
            hs                 = hs_;


#pragma mark -
#pragma mark staticメソッド
+ (AStarGraphPathPlanningNode *)node:(NavigationGraphNode *)node parentPlanningNode:(AStarGraphPathPlanningNode *)parentPlanningNode {
    AStarGraphPathPlanningNode *planningNode = [[[AStarGraphPathPlanningNode alloc] init] autorelease];

    [planningNode setNode:node];
    [planningNode setParentPlanningNode:parentPlanningNode];
    return (planningNode);
}


#pragma mark -
#pragma mark メモリマネージャ
- (void)dealloc {
    [node_ release];
    [parentPlanningNode_ release];
    [super dealloc];
}


#pragma mark -
#pragma mark publicメソッド
- (int)fs {
    return (gs_ + hs_);
}

@end