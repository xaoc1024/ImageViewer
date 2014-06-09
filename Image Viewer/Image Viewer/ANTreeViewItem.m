//
//  ANTreeViewItem.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 07.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANTreeViewItem.h"
@interface ANTreeViewItem ()

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSArray *subitems;

@property (nonatomic, assign) NSUInteger subitemsCount;

@property (nonatomic, strong) NSArray *itemContentsPathString;

@end

@implementation ANTreeViewItem
- (id)initWithItemName:(NSString *)itemName {
    self = [super init];
    if (self){
        self.itemName = itemName;
        [self initGetters];
    }
    return self;
}

- (void)setItemName:(NSString *)itemName {
    _itemName = itemName;
}

- (NSArray *)createItemComponents {
    NSMutableArray *items = [NSMutableArray array];
    ANTreeViewItem *it;
    
    for (NSString *itemName in self.itemContentsPathString){
        it = [[ANTreeViewItem alloc] initWithItemName:itemName];
        [items addObject:it];
    }
    return items;
}

- (void)initGetters {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    
    NSArray *content = [fm contentsOfDirectoryAtPath:self.itemName error:&error];
    if (error){
        NSLog(@"Error: %@", error);
        self.itemContentsPathString = nil;
        self.subitemsCount = 0;
        return;
    }
    
    NSMutableArray *directories = [NSMutableArray array];
    
    for (NSString *item in content){
        if ([item rangeOfString:@"."].location == 0){
            continue;
        }
        BOOL isDirectory = NO;
        NSString *fullPath = [self.itemName stringByAppendingPathComponent:item];
        [fm fileExistsAtPath:fullPath
                 isDirectory:&isDirectory];
        
        if (isDirectory){
            [directories addObject:fullPath];
        }
    }
    self.itemContentsPathString = directories;
    self.subitemsCount = [self.itemContentsPathString count];
}

- (NSArray *)subitems {
    if (!_subitems){
        _subitems = [self createItemComponents];
    }
    return _subitems;
}
- (void)didCollapse {
    self.subitems = nil;
}
@end
