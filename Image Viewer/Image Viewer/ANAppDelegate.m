//
//  ANAppDelegate.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 19.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANAppDelegate.h"

#import "ANImageViewerWindowController.h"
@interface ANAppDelegate()
@property (nonatomic, strong) NSImage *theImage;
@property (nonatomic, strong) ANImageViewerWindowController *imageViewerWindowController;
@end
@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.theImage = [NSImage imageNamed:@"Dog.jpg"];
    self.imageViewerWindowController = [[ANImageViewerWindowController alloc] initWithWindowNibName:@"ImageViewerWindow"];
    [self.imageViewerWindowController showWindow:self];
//    [self addImageViewToScrollView];
//    [self createScrollView];

}
- (void)addImageViewToScrollView {
    NSRect imageRect = NSMakeRect(0.0,
                                  0.0,
                                  [self.theImage size].width,
                                  [self.theImage size].height);
    
    
    // create the image view with a frame the size of the image
    NSImageView *theImageView = [[NSImageView alloc] initWithFrame:imageRect];
    [theImageView setFrame:imageRect];
    
    // set the image for the image view
    [theImageView setImage:self.theImage];
    [self.theScrollView setDocumentView:theImageView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(theImageView);
    NSMutableArray *constraints = [NSMutableArray arrayWithArray:
                                   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[theImageView]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:viewsDictionary]];
    
    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[theImageView]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary]];
    [theImageView.superview addConstraints:constraints];
    [theImageView setImageScaling:NSImageScaleAxesIndependently];

}

- (void)createScrollView {
    // theWindow is an IBOutlet that is connected to a window
    // theImage is assumed to be declared and populated already
    
    // determine the image size as a rectangle
    // theImage is assumed to be declared elsewhere
    NSRect imageRect = NSMakeRect(0.0,
                                  0.0,
                                  [self.theImage size].width,
                                  [self.theImage size].height);
    
    
    // create the image view with a frame the size of the image
    NSImageView *theImageView = [[NSImageView alloc] initWithFrame:imageRect];
    [theImageView setBounds:imageRect];
    
    // set the image for the image view
    [theImageView setImage:self.theImage];
    
    // create the scroll view so that it fills the entire window
    // to do that we'll grab the frame of the window's contentView
    // theWindow is an outlet connected to a window instance in Interface Builder
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:
                                [[self.window contentView] frame]];
    
    // the scroll view should have both horizontal
    // and vertical scrollers
    [scrollView setHasVerticalScroller:YES];
    [scrollView setHasHorizontalScroller:YES];
    
    // configure the scroller to have no visible border
    [scrollView setBorderType:NSNoBorder];
    
    // set the autoresizing mask so that the scroll view will
    // resize with the window
    [scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    
    // set theImageView as the documentView of the scroll view
    [scrollView setDocumentView:theImageView];
    
    // set the scrollView as the window's contentView
    // this replaces the existing contentView and retains
    // the scrollView, so we can release it now
    [self.window setContentView:scrollView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(scrollView);
//    NSMutableArray *constraints = [NSMutableArray arrayWithArray:
//                                   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
//                                                                           options:0
//                                                                           metrics:nil
//                                                                             views:viewsDictionary]];
//    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|"
//                                                                              options:0
//                                                                              metrics:nil
//                                                                                views:viewsDictionary]];
//    [scrollView addConstraints:constraints];
//    [[self.window contentView] addConstraints:constraints];
    
    // add constrains to image view
    viewsDictionary = NSDictionaryOfVariableBindings(theImageView);
    NSMutableArray *constraints = [NSMutableArray arrayWithArray:
                   [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[theImageView]-0-|"
                                                           options:0
                                                           metrics:nil
                                                             views:viewsDictionary]];
    [constraints addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[theImageView]-0-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:viewsDictionary]];
    [scrollView.contentView addConstraints:constraints];
    
    [theImageView setImageScaling:NSImageScaleAxesIndependently];
    // display the window
    [self.window makeKeyAndOrderFront:nil];
}

@end
