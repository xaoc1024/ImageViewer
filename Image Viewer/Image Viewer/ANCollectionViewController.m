//
//  ANCollectionViewController.m
//  Image Viewer
//
//  Created by Andriy Zhuk on 09.06.14.
//  Copyright (c) 2014 Andriy Zhuk. All rights reserved.
//

#import "ANCollectionViewController.h"
#import "ANImageItem.h"

@interface ANCollectionViewController ()

@property (strong) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSCollectionView *collectionView;

@end

@implementation ANCollectionViewController

- (void)awakeFromNib {
//    ANImageItem *ia =  [[ANImageItem alloc] init];
//    ia.image = [NSImage imageNamed:@"Lion.jpg"];
//    ia.title = @"Dog";
    self.collectionView.backgroundColors = @[[NSColor colorWithCalibratedRed:0.5f
                                                                     green:0.5f
                                                                      blue:0.5f
                                                                     alpha:1.0f]];
    [self.collectionView setSelectable:YES];
    [self.arrayController addObserver:self
                            forKeyPath:@"selectionIndexes"
                               options:NSKeyValueObservingOptionNew
                               context:nil];
    self.imageItems = [NSMutableArray array];
//    [self.arrayController addObject:ia];
}

- (void)showDataFromArray:(NSArray *)array {
    NSRange range = NSMakeRange(0, [[self.arrayController arrangedObjects] count]);
    [self.arrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    
    [self.arrayController addObjects:array];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if([keyPath isEqualTo:@"selectionIndexes"])
    {
        if([[self.arrayController selectedObjects] count] > 0)
        {
            if ([[self.arrayController selectedObjects] count] == 1)
            {
                ANImageItem * pm = (ANImageItem *) [[self.arrayController selectedObjects] objectAtIndex:0];
                NSLog(@"Only 1 selected: %@", [pm title]);
            }
            else
            {
                // More than one selected - iterate if need be
            }
        }
    }
}

@end
