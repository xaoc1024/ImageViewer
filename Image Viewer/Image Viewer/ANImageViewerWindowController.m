//
//  ANImageViewerWindowController.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 21.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANImageViewerWindowController.h"
#import "ANImageView.h"

@interface ANImageViewerWindowController (){
    NSImage *currentlyViewedImage;
}
@property (weak) IBOutlet NSView *mainView;
@property (weak) IBOutlet ANImageView *customImageView;
@end

@implementation ANImageViewerWindowController

#pragma mark - lifecycle
- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.imagePathsArray = [NSArray arrayWithObjects:
                            @"/Users/xaoc1024/Desktop/images/DSC_3045.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3121.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3203.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3204.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3243.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3249.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3282.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3284.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3303.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3315.JPG",
                            @"/Users/xaoc1024/Desktop/images/DSC_3319.JPG",
                            nil];
    
//    [self setCurrentlyViewedImage:image];
//    self.imageCounter = 0;
//    [self.window acceptsFirstResponder];
//    [self.window acceptsMouseMovedEvents];
    
}

#pragma mark - setters
- (void)setShownImageNumber:(NSInteger)shownImageNumber {
    if (shownImageNumber == -1){
        [self setCurrentlyViewedImage:[NSImage imageNamed:@"NoImages"]];
        self.window.title = @"No Images";
        return;
    }
    
    NSString *path = self.imagePathsArray[shownImageNumber];
    if ([path length]){
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSImage *image = [[NSImage alloc] initWithData:data];
        [self setCurrentlyViewedImage:image];
        self.window.title = [path lastPathComponent];
    }
    _shownImageNumber = shownImageNumber;
}

- (void)setImagePathsArray:(NSArray *)imagePathsArray {
    _imagePathsArray = imagePathsArray;
    
    if ([imagePathsArray count]){
        self.shownImageNumber = 0;
    } else {
        self.shownImageNumber = -1;
    }
}

- (void)setCurrentlyViewedImage:(NSImage *)image {
    [self.customImageView setImage:image];
}

#pragma mark - image navigation
- (void)showNextImage {
    if (self.shownImageNumber == -1){
        return;
    }
    if (self.shownImageNumber < [self.imagePathsArray count] - 1){
        self.shownImageNumber = _shownImageNumber + 1;
    }
    
}

- (void)showPrevImage {
    if (self.shownImageNumber == -1){
        return;
    }
    if (self.shownImageNumber != 0){
        self.shownImageNumber = _shownImageNumber - 1;
    }
}


- (void)keyUp:(NSEvent *)theEvent {
    NSString *s = [theEvent charactersIgnoringModifiers];
    if ([s isEqualToString:@"="]){
        [self.customImageView zoomIn];
    } else if ([s isEqualToString:@"-"]) {
        [self.customImageView zoomOut];
    } else {
        switch ([theEvent keyCode]) {
            case 123:    // Left arrow
                [self showPrevImage];
                NSLog(@"Left behind.");
                break;
            case 124:    // Right arrow
                [self showNextImage];
                NSLog(@"Right as always!");
                break;
            case 125:    // Down arrow
                [self showNextImage];
                NSLog(@"Downward is Heavenward");
                break;
            case 126:    // Up arrow
                [self showPrevImage];
                NSLog(@"Up, up, and away!");
                break;
            case 20:    //space
                [self showNextImage];
                break;
            case 30:
                // ']'
                [self.customImageView setContentMode:ANContentModeFit];
                break;
            case 42:
                // '\'
                [self.customImageView setContentMode:ANContentModeOriginalSize];
                break;
            default:
                break;
        }
    }
    NSLog(s, nil);

}

- (void)keyDown:(NSEvent *)theEvent {
    
}

@end
