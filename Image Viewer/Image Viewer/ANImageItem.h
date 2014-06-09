//
//  ANImageItem.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 09.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANImageItem : NSObject

@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

@end
