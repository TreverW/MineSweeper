//
//  MyController.m
//  MineSweeper
//
//  Created by Trever Wilhelm on 4/12/14.
//  Copyright (c) 2014 Trever Wilhelm. All rights reserved.
//
//  I figured out how to keep the state set to ON if a cell is flagged but
//  still allow for the flag to be unset using the right mouse button.
//

#import "MyController.h"

@implementation MyController

- (IBAction)clicked:(id)sender {
  int r = [sender selectedRow];
  int c = [sender selectedColumn];
  int result;
  NSButtonCell *bcell = [sender selectedCell];
  Cell *cell = [minefield cellAtRow:r Col:c];
  
  //NSLog(@"clicked: sender=%@, selected cell=%@ at row=%ld, col=%ld", sender, bcell, (long)r, (long)c);
  
  if (cell.marked) {
    // keep the button state as selected:
    [matrix setState:NSOnState atRow:r column:c];
    return; // skip this logic if the cell is marked with a flag.  
  } else {
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
    [self updateScore];
  } else {
    // No mines in vicinity, expose multiple
    [self revealExposedCells];
    [self updateScore];
  }
}

- (IBAction)newGame:(id)sender {
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
  // set the Score text
  [score setStringValue:@"Begin!"];
}

- (IBAction)levelSelect:(id)sender {
  NSInteger index = [sender indexOfSelectedItem];
  //NSLog(@"levelSelected:sender=%@, index=%ld", sender, (long)index);
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
    [matrix deselectSelectedCell];
  }
  //[matrix deselectSelectedCell];
}

-(void)detonate {
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

-(void)revealExposedCells {
  NSButtonCell *bcell;
  Cell *cell;
  // iterate over every cell
  for (int r = 0; r < minefield.height; r++) {
    for (int c = 0; c < minefield.width; c++) {
      bcell = [matrix cellAtRow:r column:c];  // Get the button cell
      cell = [minefield cellAtRow:r Col:c];   // Get the minefield cell
      if ([cell exposed] && [bcell isEnabled] && !cell.marked) {
        [matrix setState:NSOnState atRow:r column:c];            // Set it as selected
        NSLog(@"numSurroundingMines: %d", [cell numSurroundingMines]);
        [bcell setImage: nil];
        [bcell setType: NSTextCellType];
        if ([cell numSurroundingMines] > 0) {
          [bcell setTitle:[NSString stringWithFormat:@"%d",[cell numSurroundingMines]]];
        }
        [bcell setEnabled:NO];
      }
    }
  }
}

-(void)clearCell:(NSButtonCell*)bcell {
  [bcell setImage: nil];
  [bcell setType: NSTextCellType];
  [bcell setTitle: @""];
}

-(void)updateScore {
  // Calculate how many more empty cells are left to expose
  int numLeft = minefield.width * minefield.height - minefield.numExposedCells - minefield.numMines;
  if (numLeft == 0) {
    [self detonate];
    [score setStringValue:@"WINNER!"];
  } else {
    [score setStringValue:[NSString stringWithFormat:@"%d left", numLeft]];
  }
}

-(void)awakeFromNib {
  bombImage = [NSImage imageNamed:@"Bomb"];
  flagImage = [NSImage imageNamed:@"Flag"];
  minefield = [[MineField alloc] initWithWidth:10 Height:10 Mines:10];
  [minefield reset];
  [score setStringValue:@"Begin!"];
}
@end
