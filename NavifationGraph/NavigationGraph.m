//
//  NavigationGraph.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "NavigationGraph.h"
#import "NavigationGraphNode.h"
#import "Math.h"


@implementation NavigationGraph

@synthesize spacePartitioningInterval = spacePartitioningInterval_,
            spacePartitioningNodes    = spacePartitioningNodes_;


#pragma mark -
#pragma mark init
- (id)init {
    if ((self = [super init])) {
        self.spacePartitioningInterval = 100;
        spacePartitioningNodes_        = [[NSMutableDictionary alloc] init];
    }
    return (self);
}


#pragma mark -
#pragma mark static method
+ (NavigationGraph *)CreateNavigationGraphWithFloodFill:(CGPoint)startPoint receiver:(id)receiver selector:(SEL)selecter diagonal:(int)diagonal {
    NavigationGraph *graph = [[[NavigationGraph alloc] init] autorelease];
    float           height = floor((diagonal / 2) * tan([Math degreesToRadian:(TILE_DEGREES)]));
    CGPoint         start = startPoint;
    NSMutableArray  *stack = [NSMutableArray array];

    float           around[] =
    {
        -1 * diagonal / 2, 0,           
        -1 * diagonal / 2, height,      
        0,                 height,      
        diagonal / 2,      height,      
        diagonal / 2,      0,           
        diagonal / 2,      -1 * height, 
        0,                 -1 * height, 
        -1 * diagonal / 2, -1 * height  
    };

    NavigationGraphNode *node = (NavigationGraphNode *)[graph createNode];

    [node setPosition:start];

    [stack addObject:node];
    NavigationGraphNode *childNode;

    CGPoint             point1;
    int                 ii = 0;
    while (YES) {
        if ([stack count] == 0) {
            break;
        }
        node = [stack lastObject];

        while (ii < 16) {
            point1 = CGPointMake(node.position.x + around[ii], node.position.y + around[ii + 1]);
            if ([receiver performSelector:selecter withObject:[NSValue valueWithCGPoint:point1]]) {
                NavigationGraphNode *n_ = [graph searchWithPoint:point1];
                if (n_ == nil) {
                    childNode = [self searchNavigationGraphNode:stack point:point1];
                    if (childNode == nil) {
                        childNode = (NavigationGraphNode *)[graph createNode];
                        [childNode setPosition:point1];
                        [stack addObject:childNode];
                    }
                    [node addAdjacentNode:[childNode id] cost:1];
                } else {
                    [node addAdjacentNode:[n_ id] cost:1];
                }
            }
            ii = ii + 2;
        }
        ii        = 0;
        childNode = nil;
        [graph addNode:node];
        [stack removeObject:node];

        NSString *x = [[NSNumber numberWithUnsignedInt:abs([node position].x / graph.spacePartitioningInterval)] stringValue];
        NSString *y = [[NSNumber numberWithUnsignedInt:abs([node position].y / graph.spacePartitioningInterval)] stringValue];
        if ([[graph spacePartitioningNodes] objectForKey:x] == nil) {
            [[graph spacePartitioningNodes] setObject:[NSMutableDictionary dictionary] forKey:x];
        }
        if ([[[graph spacePartitioningNodes] objectForKey:x] objectForKey:y] == nil) {
            [[[graph spacePartitioningNodes] objectForKey:x] setObject:[NSMutableSet set] forKey:y];
        }
        [[[[graph spacePartitioningNodes] objectForKey:x] objectForKey:y] addObject:node];
    }
    return (graph);
}

+ (NavigationGraphNode *)searchNavigationGraphNode:(NSArray *)stack point:(CGPoint)point {
    for (NavigationGraphNode *node in stack) {
        if (point.x == node.position.x && point.y == node.position.y) {
            return (node);
        }
    }
    return (nil);
}

+(int)getDiagonal {
	return 100;
}


#pragma mark -
#pragma mark dealloc
- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark node
- (NavigationGraphNode *)createNode {
    NavigationGraphNode *node = [[[NavigationGraphNode alloc] init] autorelease];

    [node setId:++nodeIdCount_];
    return (node);
}

- (NavigationGraphNode *)getNode:(int)nodeId {
    return ([nodes_ objectForKey:[[NSNumber numberWithUnsignedInt:nodeId] stringValue]]);
}

- (void)addNode:(NavigationGraphNode *)node {
    [nodes_ setValue:node forKey:[[NSNumber numberWithUnsignedInt:[node id]] stringValue]];
}

- (void)removeNode:(NavigationGraphNode *)node {
    [nodes_ removeObjectForKey:[[NSNumber numberWithUnsignedInt:[node id]] stringValue]];
}

- (NavigationGraphNode *)searchWithPoint:(CGPoint)point {
    for (id key in nodes_) {
        NavigationGraphNode *node = [nodes_ objectForKey:key];
        if (point.x == [node position].x && point.y == [node position].y) {
            return (node);
        }
    }
    return (nil);
}

- (NavigationGraphNode *)nearestNode:(CGPoint)point {
    NavigationGraphNode *nearestNode = nil;

    for (id key in nodes_) {
        NavigationGraphNode *node = [nodes_ objectForKey:key];
        if (nearestNode == nil ||
            (abs(nearestNode.position.x - point.x) + abs(nearestNode.position.y - point.y)) > (abs(node.position.x - point.x) + abs(node.position.y - point.y))
            ) {
            nearestNode = node;
        }
    }
    return (nearestNode);
}

@end
