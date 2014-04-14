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
  NSInteger r = [sender selectedRow];
  NSInteger c = [sender selectedColumn];
  NSButtonCell *bcell = [sender selectedCell];
  NSLog(@"clicked: sender=%@, selected cell=%@ at row=%ld, col=%ld", sender, bcell, (long)r, (long)c);
}

- (IBAction)newGame:(id)sender {
  NSLog(@"newGame");
}

- (IBAction)levelSelect:(id)sender {
  NSInteger index = [sender indexOfSelectedItem];
  NSLog(@"levelSelected:sender=%@, index=%ld", sender, (long)index);
}
@end
