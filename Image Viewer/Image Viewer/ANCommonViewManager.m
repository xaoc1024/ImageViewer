//
//  ANCommonViewManager.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 09.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANCommonViewManager.h"
#import "ANCollectionViewController.h"
#import "ANOutlineViewController.h"
#import "ANImageItem.h"

@interface ANCommonViewManager () <ANCollectionViewControllerDelegate, ANOutlineViewControllerDelegate>

@end

@implementation ANCommonViewManager
#pragma mark ANOutlineViewControllerDelegate
- (void)setCollectionViewController:(ANCollectionViewController *)collectionViewController {
    _collectionViewController = collectionViewController;
    collectionViewController.delegate = self;
}

- (void)setOutlineViewController:(ANOutlineViewController *)outlineViewController {
    _outlineViewController = outlineViewController;
    outlineViewController.delegate = self;
}

- (void)outlineViewController:(ANOutlineViewController *)outlineViewController direcotryDidChange:(NSString *)directory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    
    NSMutableArray *imageItems = [NSMutableArray array];
    
    if (!error){
        for (NSString *file in contents){
            NSString *pathExtention = [[file pathExtension] lowercaseString];
            if (([pathExtention isEqualToString:@"jpg"]) ||
                ([pathExtention isEqualToString:@"png"]))
            {
                NSString *fullPath = [directory stringByAppendingPathComponent:file];
                NSImage *image = [[NSImage alloc] initWithContentsOfFile:fullPath];
                CGSize imageSize = image.size;
                float height = (128.0 * imageSize.height) / imageSize.width;
                imageSize.width = 128.0;
                imageSize.height = height;
                [image setSize:imageSize];
                
                ANImageItem *ia = [[ANImageItem alloc] init];
                ia.image = image;
                ia.title = file;
                ia.imagePath = fullPath;
                
                [imageItems addObject:ia];
            }
        }
    }
    [self.collectionViewController showDataFromArray:imageItems];
}

@end
