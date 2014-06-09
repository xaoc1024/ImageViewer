//
//  ANAppDelegate.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 19.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANAppDelegate.h"

#import "ANImageViewerWindowController.h"

#import "ANTreeViewItem.h"
#import "ANOutlineViewController.h"
#import "ANCommonViewManager.h"

@interface ANAppDelegate()<NSOutlineViewDataSource>

@property (nonatomic, strong) NSImage *theImage;
@property (nonatomic, strong) ANImageViewerWindowController *imageViewerWindowController;

@property (nonatomic, strong) NSString *basePath;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) ANTreeViewItem *baseItem;

@property (nonatomic, strong) IBOutlet ANOutlineViewController *outlineViewController;
@property (nonatomic, strong) ANCommonViewManager *commonViewManager;

@property (weak) IBOutlet ANCollectionViewController *collectionViewController;

//@property (nonatomic, strong)
@end

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.commonViewManager = [[ANCommonViewManager alloc] init];
    self.commonViewManager.outlineViewController = self.outlineViewController;
    self.commonViewManager.collectionViewController = self.collectionViewController;
    
    
    self.theImage = [NSImage imageNamed:@"Dog.jpg"];
    self.imageViewerWindowController = [[ANImageViewerWindowController alloc] initWithWindowNibName:@"ImageViewerWindow"];
    [self.imageViewerWindowController showWindow:self];
}

@end
