//
//  ANAppDelegate.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 19.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ANAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSScrollView *theScrollView;

@end
