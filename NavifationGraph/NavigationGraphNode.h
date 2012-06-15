//
//  NavigationGraphNode.h
//  Graph
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "GraphNode.h"


/**
 * NavigationGraphNode
 */
@interface NavigationGraphNode : GraphNode {
    @public
    CGPoint position_;
}

/**
 * node position
 */
@property (readwrite) CGPoint position;

@end
