//
//  MyMatrixView.m
//  MineSweeper
//
//  Created by Trever Wilhelm on 4/17/14.
//  Copyright (c) 2014 Trever Wilhelm. All rights reserved.
//

#import "MyMatrix.h"
#import "MyController.h"

@implementation MyMatrix
- (void)rightMouseDown:(NSEvent *)theEvent {
  NSInteger r, c;
  NSPoint pt = [self convertPoint:[theEvent locationInWindow] fromView:nil];
  [self getRow:&r column:&c forPoint: pt];
  NSButtonCell *bcell = [self cellAtRow:r column:c];
  if ([bcell isEnabled]) {
    [self selectCellAtRow:r column:c];
    [[self target] rightClicked:self];
  }
}
@end
