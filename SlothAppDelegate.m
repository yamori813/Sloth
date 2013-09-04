//
//  SlothAppDelegate.m
//  Sloth
//
//  Created by hiroki on 13/09/04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SlothAppDelegate.h"

@implementation SlothAppDelegate

- (void)appendOutput:(NSString *)output
{
}

- (void)processStarted
{
}

- (void)processFinished
{
}

- (void)StartScreenSaver
{
	NSLog(@"MORI MORI Debug");
	TaskWrapper *task = [[TaskWrapper alloc] initWithController:self arguments:[NSArray arrayWithObjects:
																				@"/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine",
																				nil]];
	[task startProcess];
}

- (IBAction)selectMenu:(id)sender
{
	NSLog(@"MORI MORI Debug");
	[self StartScreenSaver];
}

// http://sitearo.com/cocoa/0900_general/ccyp_StatusBar.pdf

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
    NSStatusBar *bar = [ NSStatusBar systemStatusBar ];
	NSStatusItem *sbItem = [ bar statusItemWithLength : NSVariableStatusItemLength ];
	[ sbItem retain ];
	[ sbItem setTitle	: @"Sloth"	]; // タイトルをセット
//	[ sbItem setToolTip	: @"Hello!" ]; // ツールチップをセット
	[ sbItem setHighlightMode : YES	]; // クリック時にハイライト表示
	[ sbItem	setMenu : sbmenu	];
	[ self registerHotKey];

}

// http://stackoverflow.com/questions/4639244/osx-keyboard-shortcut-background-application-how-to

- (void)handleHotKeyPress {
    //handle key press
	[self StartScreenSaver];
}
- (void)handleHotKeyRelease {
    //handle key release
}

OSStatus HotKeyEventHandlerProc(EventHandlerCallRef inCallRef, EventRef ev, void* inUserData) {
    OSStatus err = noErr;
    if(GetEventKind(ev) == kEventHotKeyPressed) {
        [(id)inUserData handleHotKeyPress];
    } else if(GetEventKind(ev) == kEventHotKeyReleased) {
        [(id)inUserData handleHotKeyRelease];
    } else err = eventNotHandledErr;
    return err;
}

//EventHotKeyRef hotKey; instance variable

- (void)installEventHandler {
    static BOOL installed = NO;
    if(installed) return;
    installed = YES;
    const EventTypeSpec hotKeyEvents[] = {{kEventClassKeyboard,kEventHotKeyPressed},{kEventClassKeyboard,kEventHotKeyReleased}};
    InstallApplicationEventHandler(NewEventHandlerUPP(HotKeyEventHandlerProc),GetEventTypeCount(hotKeyEvents),hotKeyEvents,(void*)self,NULL);
}

- (void)registerHotKey {
    [self installEventHandler];
    UInt32 virtualKeyCode = 37; // l
//    UInt32 modifiers = cmdKey|shiftKey|optionKey|controlKey; //remove the modifiers you don't want
    UInt32 modifiers = cmdKey|shiftKey; //remove the modifiers you don't want
    EventHotKeyID eventID = {'Slot','1234'}; //These can be any 4 character codes. It can be used to identify which key was pressed
    RegisterEventHotKey(virtualKeyCode,modifiers,eventID,GetApplicationEventTarget(),0,(EventHotKeyRef*)&hotKey);
}

- (void)unregisterHotKey {
    if(hotKey) UnregisterEventHotKey(hotKey);
    hotKey = 0;
}

@end
