//
//  WETouchableView.h
//  WEPopover
//
//  Created by Werner Altewischer on 12/21/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FFTouchableView;

/**
  * delegate to receive touch events
  */
@protocol FFTouchableViewDelegate<NSObject>

@optional
- (void)viewWasTouched:(FFTouchableView *)view;
- (CGRect)fillRectForView:(FFTouchableView *)view;

@end

/**
 * View that can handle touch events and/or disable touch forwording to child views
 */
@interface FFTouchableView : UIView

@property (nonatomic, assign) BOOL touchForwardingDisabled;
@property (nonatomic, weak) id <FFTouchableViewDelegate> delegate;
@property (nonatomic, copy) NSArray *passthroughViews;
@property (nonatomic, strong) UIView *fillView;

- (void)setFillColor:(UIColor *)fillColor;

@end
