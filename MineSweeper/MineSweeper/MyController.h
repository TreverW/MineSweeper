//
//  MyController.h
//  MineSweeper
//
//  Created by Trever Wilhelm on 4/12/14.
//  Copyright (c) 2014 Trever Wilhelm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyController : NSObject {
    IBOutlet NSTextField *score;
    IBOutlet NSMatrix *matrix;
}
- (IBAction)clicked:(id)sender;
- (IBAction)newGame:(id)sender;
- (IBAction)levelSelect:(id)sender;

@end
