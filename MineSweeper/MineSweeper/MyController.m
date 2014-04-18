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
  int result;
  NSButtonCell *bcell = [sender selectedCell];
  Cell *cell = [minefield cellAtRow:r Col:c];
  
  NSLog(@"clicked: sender=%@, selected cell=%@ at row=%ld, col=%ld", sender, bcell, (long)r, (long)c);
  
  if (!cell.marked) {
    result = [minefield exposeCellAtRow:r Col:c];
  }
  
  // Handle the resut of the exposed cell
  if (result == -1) {
    // Detonate a bomb
    [bcell setImage:bombImage];
    [score setStringValue:@"BOOM!"];
    [self detonate];
  } else if (result >= 1 && result <= 8) {
    // 1 <= n <= 8, exactly one cell has been exposed
    [bcell setImage: nil];
    [bcell setType: NSTextCellType];
    [bcell setTitle:[NSString stringWithFormat:@"%d", result]];
    [bcell setEnabled:NO];
  } else {
    // No mines in vicinity, expose multiple
  }
}

- (IBAction)newGame:(id)sender {
  NSLog(@"newGame");
  // Reset the minefield
  [minefield reset];
  // Reset the board buttons
  // iterate over every cell
  for (int r = 0; r < minefield.height; r++) {
    for (int c = 0; c < minefield.width; c++) {
      NSButtonCell *bcell = [matrix cellAtRow:r column:c];  // Get the button cell
      [self clearCell:bcell];
      [bcell setEnabled:YES];
    }
  }
  [matrix deselectAllCells];
}

- (IBAction)levelSelect:(id)sender {
  NSInteger index = [sender indexOfSelectedItem];
  NSLog(@"levelSelected:sender=%@, index=%ld", sender, (long)index);
}

- (void)rightClicked:(id)sender {
  int r = [sender selectedRow];
  int c = [sender selectedColumn];
  NSButtonCell *bcell = [sender selectedCell];
  Cell *cell = [minefield cellAtRow:r Col:c];
  // mark or unmark mine

  // Toggle the cell value
  cell.marked = !cell.marked;
  if (cell.marked) {
    [bcell setImage:flagImage];
  } else {
    [self clearCell:bcell];
  }
  [matrix deselectSelectedCell];
}

-(void) detonate {
  NSButtonCell *bcell;
  Cell *cell;

  // iterate over every cell
  for (int r = 0; r < minefield.height; r++) {
    for (int c = 0; c < minefield.width; c++) {
      bcell = [matrix cellAtRow:r column:c];  // Get the button cell
      cell = [minefield cellAtRow:r Col:c];   // Get the minefield cell
      if ([cell hasMine]) {
        [bcell setImage:bombImage];           // Draw the bomb
      }
      [bcell setEnabled:NO];                  // Disable the button
    }
  }
}

-(void)clearCell:(NSButtonCell*)bcell {
  [bcell setImage: nil];
  [bcell setType: NSTextCellType];
  [bcell setTitle: @""];
}

-(void)awakeFromNib {
  bombImage = [NSImage imageNamed:@"Bomb"];
  flagImage = [NSImage imageNamed:@"Flag"];
  minefield = [[MineField alloc] initWithWidth:10 Height:10 Mines:10];
  [minefield reset];
}
@end
