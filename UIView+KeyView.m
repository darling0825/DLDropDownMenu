/*
 *  UIBarButtonItem+WEPopover.m
 *  WEPopover
 *
 *  Created by Werner Altewischer on 07/05/11.
 *  Copyright 2010 Werner IT Consultancy. All rights reserved.
 *
 */

#import "UIView+KeyView.h" 

@implementation UIView(KeyView)

- (BOOL)isView:(UIView *)v1 inSameHierarchyAsView:(UIView *)v2 {
    BOOL inViewHierarchy = NO;
    while (v1 != nil) {
        if (v1 == v2) {
            inViewHierarchy = YES;
            break;
        }
        v1 = v1.superview;
    }
    return inViewHierarchy;
}

- (UIView *)keyViewForView:(UIView *)theView {
    UIWindow *w = nil;
    if (theView.window) {
        w = theView.window;
    } else {
        w = [[UIApplication sharedApplication] keyWindow];
    }
    if (w.subviews.count > 0 && (theView == nil || [self isView:theView inSameHierarchyAsView:[w.subviews objectAtIndex:0]])) {
        return [w.subviews objectAtIndex:0];
    } else {
        return w;
    }
}
@end
