//
//  MyController.h
//  MineSweeper
//
//  Created by Trever Wilhelm on 4/12/14.
//  Copyright (c) 2014 Trever Wilhelm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineField.h"

@interface MyController : NSObject {
    IBOutlet NSTextField *score;
    IBOutlet NSMatrix *matrix;
    MineField *minefield;
    NSImage *bombImage;
    NSImage *flagImage;
}
- (IBAction)clicked:(id)sender;
- (IBAction)newGame:(id)sender;
- (IBAction)levelSelect:(id)sender;
- (void)rightClicked:(id)sender;
- (void)detonate;
- (void)revealExposedCells;
- (void)clearCell:(NSButtonCell*)bcell;
@end
