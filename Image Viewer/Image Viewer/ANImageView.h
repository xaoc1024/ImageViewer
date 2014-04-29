//
//  ANImageView.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 27.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
typedef enum {
    ANContentModeFit = 0,
    ANContentModeOriginalSize
} ANContentMode;

@interface ANImageView : NSView
@property (nonatomic, assign) ANContentMode contentMode;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, assign) float imageScale;
- (void)zoomIn;
- (void)zoomOut;
@end
