//
//  ANCollectionViewController.h
//  Image Viewer
//
//  Created by Andriy Zhuk on 09.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ANCollectionViewControllerDelegate;

@interface ANCollectionViewController : NSObject

@property (strong) NSMutableArray *imageItems;

@property (nonatomic, weak) id <ANCollectionViewControllerDelegate> delegate;

- (void)showDataFromArray:(NSArray *)array;

@end

@protocol  ANCollectionViewControllerDelegate  <NSObject>


@end