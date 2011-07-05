//
//  NavigationGraphNode.m
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "NavigationGraphNode.h"


@implementation NavigationGraphNode

@synthesize position = position_;


#pragma mark -
#pragma mark init
- (id)init {
    if ((self = [super init])) {
    }
    return (self);
}

#pragma mark -
#pragma mark dealloc
- (void)dealloc {
    [super dealloc];
}

@end
