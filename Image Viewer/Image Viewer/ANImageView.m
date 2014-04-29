//
//  ANImageView.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 27.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANImageView.h"
#import <QuartzCore/CoreAnimation.h>

CGPoint ANLayerCenter(CALayer *layer) {
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
@end

@implementation ANImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBackgroundColor:[NSColor blackColor].CGColor];
    self.layer.magnificationFilter = kCAFilterTrilinear;
    self.contentLayer.magnificationFilter = kCAFilterTrilinear;
    self.imageScale = 1.0f;
//    self.contentLayer.bounds = self.bounds;
    self.contentLayer.position = ANLayerCenter(self.layer);

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
    _contentMode = contentMode;
    switch (contentMode) {
        case ANContentModeFit:
            self.imageScale = ANCalculateScaleToFit(self.bounds.size, self.image.size);
            break;
        case ANContentModeOriginalSize:
            self.imageScale = 1.0;
            break;
        default:
            break;
    }
}

- (void)setImage:(NSImage *)image {
//    [self.contentLayer setTransform:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    CALayer *newLayer = [CALayer layer];
    newLayer.opacity = 0.0f;
    
    CGRect bounds = [self.layer bounds];
    CGPoint center = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 2.0);
    
    newLayer.contents = image;
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
    [self.contentLayer setPosition:ANLayerCenter(self.layer)];
    
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
    NSLog(@"Mouse Down");
}

- (void)mouseDragged:(NSEvent *)theEvent {
//    NSLog(@"Mouse dragged");
}

-(void)mouseUp:(NSEvent *)theEvent {
//    NSLog(@"Mouse up");
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
