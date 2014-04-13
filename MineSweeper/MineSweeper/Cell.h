//
//  Cell.h
//  mineproto
//


#import <Cocoa/Cocoa.h>

@interface Cell : NSObject

@property(readwrite, nonatomic) BOOL hasMine;   // Cell contain a mine?
@property(readwrite, nonatomic) BOOL exposed;   // Has the cell has been exposed (may or may not have mine)?
@property(readwrite, nonatomic) BOOL marked;    // Cell marked as having a mine (perhaps incorrectly)?
@property(readwrite, nonatomic) char numSurroundingMines;  // number of mines in 8 adjacent cells

-(id)init;

@end
