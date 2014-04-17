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
  Cell *cell = [minefield cellAtRow:r Col:c];
  
  NSLog(@"clicked: sender=%@, selected cell=%@ at row=%ld, col=%ld", sender, bcell, (long)r, (long)c);
  
  if (!cell.marked) {
    int result = [minefield exposeCellAtRow:r Col:c];
  }
  
  // Toggle the cell value
  cell.marked = !cell.marked;
  if (cell.marked) {
    [bcell setImage:flagImage];
  } else {
    [bcell setImage: nil];
    [bcell setType: NSTextCellType];
    [bcell setTitle: @""];
  }
  [matrix deselectSelectedCell];
}

- (IBAction)newGame:(id)sender {
  NSLog(@"newGame");
}

- (IBAction)levelSelect:(id)sender {
  NSInteger index = [sender indexOfSelectedItem];
  NSLog(@"levelSelected:sender=%@, index=%ld", sender, (long)index);
}

-(void)awakeFromNib {
  bombImage = [NSImage imageNamed:@"Bomb"];
  flagImage = [NSImage imageNamed:@"Flag"];
  minefield = [[MineField alloc] initWithWidth:10 Height:10 Mines:10];
  [minefield reset];
}
@end
