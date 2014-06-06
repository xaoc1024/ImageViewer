//
//  ANFileViewerViewController.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 24.05.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANFileViewerViewController.h"

@interface ANFileViewerViewController ()<NSOutlineViewDataSource, NSOutlineViewDelegate, NSCollectionViewDelegate>

@property (weak) IBOutlet NSCollectionView *filesCollectionView;
@property (weak) IBOutlet NSOutlineView *filesOutlinedView;

@end

@implementation ANFileViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

#pragma mark - NSOutlineViewDataSource
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    return @"f";
}
@end
