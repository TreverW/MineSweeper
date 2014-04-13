//
//  MineField.h
//  mineproto
//
//  Created by Wayne Cochran on 4/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cell.h"

@interface MineField : NSObject

@property(readonly, nonatomic) NSMutableArray *cells;  // grid of cells
@property(readonly, nonatomic) int numMines;           // total number of mines
@property(readonly, nonatomic) int numExposedCells;    // num of cells exposed
@property(readonly, nonatomic) BOOL kablooey;          // mine field detonated

-(id)initWithWidth:(int)w Height:(int)h Mines:(int)m;
-(int)width;
-(int)height;
-(Cell*)cellAtRow:(int)r Col:(int)c;
-(void)reset;
-(int)unexposedCells;
-(int)exposeCellAtRow:(int)r Col:(int)c;
-(BOOL)autoExposeCellAtRow:(int)r Col:(int)c;

@end
