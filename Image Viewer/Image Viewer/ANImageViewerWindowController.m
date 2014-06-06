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
                            @"/Users/xaoc1024/Desktop/AppInstaller/Imaged DES/leopard.jpg",
                            @"/Users/xaoc1024/Desktop/AppInstaller/Imaged DES/Lion.jpg",
                            @"/Users/xaoc1024/Desktop/AppInstaller/Imaged DES/Parrot.jpg",
                            @"/Users/xaoc1024/Desktop/AppInstaller/Imaged DES/SmilingDog.jpg",
                            @"/Users/xaoc1024/Downloads/IMG_28042014_212412.png",
                            @"/Users/xaoc1024/Downloads/001.JPG",
                             nil];
    
//    [self setCurrentlyViewedImage:image];
//    self.imageCounter = 0;
//    [self.window acceptsFirstResponder];
//    [self.window acceptsMouseMovedEvents];
    
}

#pragma mark - setters
- (void)setImageCounter:(NSInteger)imageCounter {
    if (imageCounter == -1){
        [self setCurrentlyViewedImage:[NSImage imageNamed:@"NoImages"]];
        self.window.title = @"No Images";
        return;
    }
    
    NSString *path = self.imagePathsArray[imageCounter];
    if ([path length]){
        NSImage *image = [[NSImage alloc] initByReferencingFile:path];
        [self setCurrentlyViewedImage:image];
        self.window.title = [path lastPathComponent];
    }
    _imageCounter = imageCounter;
}

- (void)setImagePathsArray:(NSArray *)imagePathsArray {
    _imagePathsArray = imagePathsArray;
    
    if ([imagePathsArray count]){
        self.imageCounter = 0;
    } else {
        self.imageCounter = -1;
    }
}

- (void)setCurrentlyViewedImage:(NSImage *)image {
    [self.customImageView setImage:image];
}

#pragma mark - image navigation
- (void)showNextImage {
    if (self.imageCounter == -1){
        return;
    }
    if (self.imageCounter < [self.imagePathsArray count] - 1){
        self.imageCounter = _imageCounter + 1;
    }
    
}

- (void)showPrevImage {
    if (self.imageCounter == -1){
        return;
    }
    if (self.imageCounter != 0){
        self.imageCounter = _imageCounter - 1;
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
