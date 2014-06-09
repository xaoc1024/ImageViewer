//
//  ANOutlineViewController.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 07.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANOutlineViewController.h"
#import "ANTreeViewItem.h"

@interface ANOutlineViewController()
@property (nonatomic, strong) NSString *basePath;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) ANTreeViewItem *baseItem;
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (weak) IBOutlet NSOutlineView *outlineView;
@end

@implementation ANOutlineViewController

- (void)awakeFromNib {
    self.basePath = NSHomeDirectory();
    self.baseItem = [[ANTreeViewItem alloc] initWithItemName:self.basePath];
    
}

#pragma mark - NSOutlineViewDataSource
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return (!item) ? 1 : [item subitemsCount];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return !item ? YES : [item subitemsCount] != 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (!item){
        return self.baseItem;
    }
    return [item subitems][index];
}


- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return [[item itemName] lastPathComponent];
}

#pragma mark - NSOutlineViewDelegate
- (void)outlineViewItemWillExpand:(NSNotification *)notification {
    ANTreeViewItem *item = [[notification userInfo] objectForKey:@"NSObject"];
}

- (void)outlineViewItemDidCollapse:(NSNotification *)notification {
    ANTreeViewItem *item = [[notification userInfo] objectForKey:@"NSObject"];
    [item didCollapse];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    ANTreeViewItem *selectedItem = [self.outlineView itemAtRow:[self.outlineView selectedRow]];
    [self.delegate outlineViewController:self direcotryDidChange:selectedItem.itemName];
}
@end
