//
//  ANTreeViewItem.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 07.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANTreeViewItem : NSObject

@property (nonatomic, strong, readonly) NSString *itemName;
@property (nonatomic, strong, readonly) NSArray *subitems;

@property (nonatomic, assign, readonly) NSUInteger subitemsCount;


- (id)initWithItemName:(NSString *)itemName;
- (NSUInteger)subitemsCount;

- (void)didCollapse;

@end
