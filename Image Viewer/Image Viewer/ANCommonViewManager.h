//
//  ANCommonViewManager.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 09.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ANOutlineViewController;
@class ANCollectionViewController;

@interface ANCommonViewManager : NSObject

@property (nonatomic, strong) ANOutlineViewController *outlineViewController;
@property (nonatomic, strong) ANCollectionViewController *collectionViewController;

@end
