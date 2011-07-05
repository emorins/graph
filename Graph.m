//
//  Graph.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "Graph.h"
#import "GraphNode.h"


@implementation Graph

@synthesize nodes = nodes_;


#pragma mark -
#pragma mark init
- (id)init {
    if ((self = [super init])) {
        [self setNodes:[NSMutableDictionary dictionary]];
        nodeIdCount_ = 0;
    }
    return (self);
}


#pragma mark -
#pragma mark dealloc
- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark public method
- (GraphNode *)createNode {
    GraphNode *node = [[[GraphNode alloc] init] autorelease];

    [node setId:++nodeIdCount_];
    return (node);
}

- (GraphNode *)getNode:(int)nodeId {
    return ([nodes_ objectForKey:[[NSNumber numberWithUnsignedInt:nodeId] stringValue]]);
}

- (void)addNode:(GraphNode *)node {
    [nodes_ setValue:[node retain] forKey:[[NSNumber numberWithUnsignedInt:[node id]] stringValue]];
}

- (void)removeNode:(GraphNode *)node {
    [nodes_ removeObjectForKey:[[NSNumber numberWithUnsignedInt:[node id]] stringValue]];
}

- (int)nodeCount {
    return ([nodes_ count]);
}

-(NSArray *)activeNodes {
	NSMutableArray *arr = [NSMutableArray array];
	for (id key in nodes_) {
		id node = [nodes_ objectForKey:key];
		if ([node isActive]) {
			[arr addObject:node];
		}
	}
	return (NSArray *)arr;
}

@end
