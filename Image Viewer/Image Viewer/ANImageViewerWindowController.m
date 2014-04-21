//
//  ANImageViewerWindowController.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 21.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANImageViewerWindowController.h"

@interface ANImageViewerWindowController ()

@property (weak) IBOutlet NSScrollView *theScrollView;
@property (weak) IBOutlet NSView *theViewInScrollView;
@end

@implementation ANImageViewerWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (void)keyUp:(NSEvent *)theEvent {
    NSString *s = [theEvent charactersIgnoringModifiers];
    NSLog(s, nil);
}
@end
