//
//  MyController.m
//  MineSweeper
//
//  Created by Trever Wilhelm on 4/12/14.
//  Copyright (c) 2014 Trever Wilhelm. All rights reserved.
//

#import "MyController.h"

@implementation MyController

- (IBAction)clicked:(id)sender {
  int r = [sender selectedRow];
  int c = [sender selectedColumn];
  NSButtonCell *bcell = [sender selectedCell];
  NSLog(@"clicked: sender=%@, selected cell=%@ at row=%d, col=%d", sender, bcell, r, c);
}

- (IBAction)newGame:(id)sender {
  NSLog(@"newGame");
}

- (IBAction)levelSelect:(id)sender {
  int index = [sender indexOfSelectedItem];
  NSLog(@"levelSelected:sender=%@, index=%d", sender, index);
}
@end
