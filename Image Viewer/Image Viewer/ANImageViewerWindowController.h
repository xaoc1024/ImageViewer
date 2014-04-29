//
//  ANImageViewerWindowController.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 21.04.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ANImageViewerWindowController : NSWindowController
@property (nonatomic, strong) NSArray *imagePathsArray;
@property (nonatomic, assign) NSInteger imageCounter;
@end
