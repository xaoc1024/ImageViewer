//
//  ANAppDelegate.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 19.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANAppDelegate.h"

#import "ANImageViewerWindowController.h"
#import "ANFileViewerViewController.h"


@interface ANAppDelegate()
@property (nonatomic, strong) NSImage *theImage;
@property (nonatomic, strong) ANImageViewerWindowController *imageViewerWindowController;
@property (nonatomic, strong) ANFileViewerViewController* fileViewerViewController;
@end

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.theImage = [NSImage imageNamed:@"Dog.jpg"];
    self.imageViewerWindowController = [[ANImageViewerWindowController alloc] initWithWindowNibName:@"ImageViewerWindow"];
    [self.imageViewerWindowController showWindow:self];
    
    ANFileViewerViewController *vc = [[ANFileViewerViewController alloc] initWithNibName:@"FileViewerView" bundle:[NSBundle mainBundle]];
    
    [self.window setContentView:vc.view];
}

@end
