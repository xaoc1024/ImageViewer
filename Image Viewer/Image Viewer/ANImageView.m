//
//  ANImageView.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 27.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANImageView.h"
#import <QuartzCore/CoreAnimation.h>

CGPoint ANCalculateLayerCenter(CALayer *layer) {
    CGPoint center;
    center.x = layer.frame.size.width / 2.0;
    center.y = layer.frame.size.height / 2.0;
    return center;
}

float ANCalculateScaleToFit(CGSize viewSize, CGSize imageSize){
    float newScale = 1.0f;
    float imageRatio = imageSize.width / imageSize.height;
    float viewRatio = viewSize.width / viewSize.height;
    
    if (viewRatio >= 1.0f){
        newScale = (viewRatio >= imageRatio) ? viewSize.height / imageSize.height : viewSize.width / imageSize.width;
    } else {
        newScale = (viewRatio < imageRatio) ? viewSize.width / imageSize.width : viewSize.height / imageSize.height;
    }
    return newScale;
}


@interface ANImageView ()
@property (nonatomic, strong) CALayer *contentLayer;
@property (nonatomic, assign) NSPoint mouseDownLocation;
@property (nonatomic, assign) NSPoint layerPosition;

@end

@implementation ANImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBackgroundColor:[NSColor blackColor].CGColor];
    self.imageScale = 1.0f;
//    self.contentLayer.bounds = self.bounds;
    self.contentLayer.position = ANCalculateLayerCenter(self.layer);

}

#pragma mark - getters
- (CALayer *)contentLayer {
    if (!_contentLayer){
        _contentLayer = [CALayer layer];
        [self.layer addSublayer:_contentLayer];
    }
    return _contentLayer;
}

#pragma mark - setters
- (void)setContentMode:(ANContentMode)contentMode {
    switch (contentMode) {
        case ANContentModeFit:
            self.imageScale = ANCalculateScaleToFit(self.bounds.size, self.image.size);
            self.contentLayer.position = ANCalculateLayerCenter(self.layer);
            break;
        case ANContentModeOriginalSize:
            self.imageScale = 1.0;
            self.contentLayer.position = ANCalculateLayerCenter(self.layer);
            break;
        default:
            break;
    }
    _contentMode = contentMode;
}

- (void)setImage:(NSImage *)image {
    [self.contentLayer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    CALayer *newLayer = [CALayer layer];
    newLayer.opacity = 0.0f;
    
    CGRect bounds = [self.layer bounds];
    CGPoint center = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 2.0);
    
    newLayer.contents = image;
    newLayer.magnificationFilter = kCAFilterTrilinear;
    newLayer.contentsGravity = kCAGravityResizeAspect; //(self.contentMode == ANContentModeFit) ? kCAGravityResizeAspect : nil;
    [newLayer setBackgroundColor:[NSColor blackColor].CGColor];
    
    bounds.size = image.size;
    [newLayer setBounds:bounds];
    [newLayer setPosition:center];
    [self.layer addSublayer:newLayer];
    
    CABasicAnimation* fadeInAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    // face in
    fadeInAnim.fromValue = [NSNumber numberWithFloat:0.0];
    fadeInAnim.toValue = [NSNumber numberWithFloat:1.0];
    fadeInAnim.duration = 0.2f;
    
    [CATransaction setCompletionBlock:^(){
        [self.contentLayer removeFromSuperlayer];
        self.contentLayer = newLayer;
        [CATransaction setCompletionBlock:nil];
        NSLog(@"Completion block");
    }];
    
    [newLayer addAnimation:fadeInAnim forKey:@"opacity"];
    newLayer.opacity = 1.0;
    _image = image;
}

- (void)setImageScale:(float)scale {
    if (scale != 1.0){
        _contentMode = ANContentModeScaled;
    }
    _imageScale = scale;
    CGSize newSize;
    newSize.height = self.image.size.height * scale;
    newSize.width = self.image.size.width * scale;
    
    CGRect newBounds;
    newBounds.size = newSize;
    newBounds.origin.x = 0;
    newBounds.origin.y = 0;
    
    [self.contentLayer setBounds:newBounds];
}

#pragma mark - overriden
-(void)viewDidEndLiveResize {
    [super viewDidEndLiveResize];
    [self.contentLayer setPosition:ANCalculateLayerCenter(self.layer)];
    
    switch (self.contentMode) {
        case ANContentModeFit:
            self.imageScale = ANCalculateScaleToFit(self.bounds.size, self.image.size);
            break;
            
        case ANContentModeOriginalSize:
            self.imageScale = 1.0;
            break;
            
        default:
            break;
    }
//    self.contentLayer.bounds = self.bounds;
}


- (BOOL)acceptsFirstResponder {
    return YES;
}

-(void)mouseDown:(NSEvent *)theEvent {
    if (((self.contentMode == ANContentModeOriginalSize)
        || (self.contentMode == ANContentModeScaled))
        && ((self.contentLayer.bounds.size.width > self.bounds.size.width)
        || (self.contentLayer.bounds.size.height > self.bounds.size.height)))
    {
        self.mouseDownLocation = [theEvent locationInWindow];
        self.layerPosition = self.contentLayer.position;
    }
//    self.mouseDownLocation = [self.layer convertPoint:self.mouseDownLocation toLayer:self.contentLayer];
    NSLog(@"Mouse Down");
}

- (void)mouseDragged:(NSEvent *)theEvent {
    if (((self.contentMode == ANContentModeOriginalSize)
        || (self.contentMode == ANContentModeScaled))
        && ((self.contentLayer.bounds.size.width > self.bounds.size.width)
        || (self.contentLayer.bounds.size.height > self.bounds.size.height)))
    {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        //change background colour
        
        NSPoint loc = [theEvent locationInWindow];
        NSSize shiftSize;
        shiftSize.width = loc.x - self.mouseDownLocation.x;
        shiftSize.height = loc.y - self.mouseDownLocation.y;
        
        CGPoint newPosition = self.layerPosition;
        if (self.contentLayer.bounds.size.width > self.layer.bounds.size.width){
            newPosition.x += shiftSize.width;
        }
        if (self.contentLayer.bounds.size.height > self.layer.bounds.size.height){
            newPosition.y += shiftSize.height;
        }
        self.contentLayer.position = newPosition;
        [CATransaction commit];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    if (((self.contentMode == ANContentModeOriginalSize)
         || (self.contentMode == ANContentModeScaled))
        && ((self.contentLayer.bounds.size.width > self.bounds.size.width)
            || (self.contentLayer.bounds.size.height > self.bounds.size.height)))
    {
        CGRect contentFrame = self.contentLayer.frame;
        CGRect layerBounds = self.layer.bounds;
        
        float contentWidth = self.contentLayer.bounds.size.width;
        float contentHeight = self.contentLayer.bounds.size.height;
        
        float layerWidth = layerBounds.size.width;
        float layerHeight = layerBounds.size.height;
        
        CGPoint newPosition = self.contentLayer.position;
        
        if (contentWidth > layerWidth){
            float shift = layerWidth - (contentFrame.origin.x + contentFrame.size.width);
            
            if (shift > 0){
                newPosition.x += shift;
            } else if (contentFrame.origin.x > 0.0f) {
                newPosition.x -= contentFrame.origin.x;
            }
        }
        
        if (contentHeight > layerHeight){
            float upperShift = layerHeight - (contentFrame.origin.y + contentFrame.size.height);
            if (upperShift > 0){
                newPosition.y += upperShift;
            } else if (contentFrame.origin.y > 0){
                newPosition.y -= contentFrame.origin.y;
            }
        }
        self.contentLayer.position = newPosition;
    }
}

#pragma mark - public
- (void)zoomIn {
    if (_imageScale >= 10){
        return;
    }
    if (_imageScale >= 1){
        self.imageScale += _imageScale;
    } else {
        self.imageScale = _imageScale * 2.0f;
    }
}

- (void)zoomOut {
    if (_imageScale <= 0.125f){
        return;
    }
    self.imageScale = _imageScale / 2.0;
}

@end
