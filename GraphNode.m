//
//  GraphNode.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "GraphNode.h"


@implementation GraphNode

@synthesize adjacentNodes = adjacentNodes_,
            id            = id_,
            isActive      = isActive_;


#pragma mark -
#pragma mark init
- (id)init {
    if ((self = [super init])) {
        [self setAdjacentNodes:[NSMutableDictionary dictionary]];
        [self setIsActive:YES];
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
- (void)addAdjacentNode:(int)nodeId cost:(int)cost {
    [adjacentNodes_ setValue:[[NSNumber numberWithUnsignedInt:cost] stringValue] forKey:[[NSNumber numberWithUnsignedInt:nodeId] stringValue]];
}

- (int)getAdjacentNode:(int)nodeId {
    return ([[adjacentNodes_ objectForKey:[[NSNumber numberWithUnsignedInt:nodeId] stringValue]] intValue]);
}

- (void)removeAdjacentNode:(int)nodeId {
    [adjacentNodes_ removeObjectForKey:[[NSNumber numberWithUnsignedInt:nodeId] stringValue]];
}

@end
