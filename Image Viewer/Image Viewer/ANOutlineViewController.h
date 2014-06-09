//
//  ANOutlineViewController.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 07.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ANOutlineViewControllerDelegate;
@interface ANOutlineViewController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate>
@property (nonatomic, weak) id <ANOutlineViewControllerDelegate> delegate;
@end

@protocol  ANOutlineViewControllerDelegate  <NSObject>

- (void)outlineViewController:(ANOutlineViewController *)outlineViewController direcotryDidChange:(NSString *)directory;

@end