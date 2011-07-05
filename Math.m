//
//  Math.m
//  Math
//
//  Created by Shotaro Emori on 11/04/14.
//  Copyright 2011 Shotaro Emori All rights reserved.
//

#import "Math.h"


@implementation Math

+ (double) degreesToRadian:(double)degrees {
    return (degrees * M_PI / 180);
}

+ (double) radianToDegrees:(double)radian {
    return (radian * 180 / M_PI);
}

@end
