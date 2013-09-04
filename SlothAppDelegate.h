//
//  SlothAppDelegate.h
//  Sloth
//
//  Created by hiroki on 13/09/04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

#import "TaskWrapper.h"

@interface SlothAppDelegate : NSObject <NSApplicationDelegate, TaskWrapperController> {
	IBOutlet NSMenu *sbmenu;
	EventHotKeyRef hotKey;
}

- (IBAction)selectMenu:(id)sender;

@end
