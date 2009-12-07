#import "CTFWhitelistWindowController.h"
#import "SparkleManager.h"

NSString *kCTFCheckForUpdates = @"CTFCheckForUpdates";

@interface CTFWhitelistWindowController (private)

- (NSUInteger)getEmptyWhitelistRowIndex;

@end

@implementation CTFWhitelistWindowController (private)

- (NSUInteger)getEmptyWhitelistRowIndex
{
	id controllerObjects = [_controller arrangedObjects];
	return [controllerObjects indexOfObject:[NSDictionary dictionary]];
}

@end

@implementation CTFWhitelistWindowController

- (id)init
{
    NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
    NSString *nibPath = [myBundle pathForResource:@"WhitelistPanel" ofType:@"nib"];
    if (nibPath == nil) {
        [self dealloc];
        return nil;
    }
    
    self = [super initWithWindowNibPath: nibPath owner: self];

    return self;
}

- (void)windowDidLoad
{
    [_checkNowButton setEnabled:[[SparkleManager sharedManager] canUpdate]];
	
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whitelistDidUpdate:) name:@"ClickToFlashPluginDefaultsDidChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewDidChange:) name:@"NSTableViewSelectionDidChangeNotification" object:_whitelistTableView];
    
}

- (IBAction)checkForUpdates:(id)sender;
{
	[[SparkleManager sharedManager] checkForUpdates];
}

- (IBAction)automaticallyCheckForUpdatesDidChange:(id)sender;
{
	[[SparkleManager sharedManager] setAutomaticallyChecksForUpdates:[sender state]];
}

- (NSString *)versionString
{
	NSBundle *CTFBundle = [NSBundle bundleWithIdentifier:@"com.github.rentzsch.clicktoflash"];
	return [CTFBundle objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

- (void)selectRowAtIndex:(NSNumber *)rowNum
{
	[_whitelistTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:[rowNum unsignedIntegerValue]] byExtendingSelection:NO];
	[_whitelistTableView scrollRowToVisible:[rowNum integerValue]];
	[_whitelistTableView editColumn:0 row:[rowNum integerValue] withEvent:nil select:YES];
}

- (void)selectEmptyRow
{
	NSUInteger emptyRow = [self getEmptyWhitelistRowIndex];
	
	if( emptyRow != NSNotFound )
	{
		[self selectRowAtIndex:[NSNumber numberWithUnsignedInteger:emptyRow]];
	}
}

#pragma mark Whitelist manipulation
- (IBAction)addToWhitelist:(id)sender
{	
	NSUInteger emptyRow = [self getEmptyWhitelistRowIndex];
	
	if( emptyRow == NSNotFound )
	{
		[_controller add:sender];
	}
	
	[self performSelector:@selector(selectEmptyRow) withObject:nil afterDelay:0];
}

- (IBAction)removeFromWhitelist:(id)sender
{
    [_controller remove:sender];
}


#pragma mark Uninstallation

- (IBAction)uninstallClickToFlash:(id)sender;
{
	[NSApp beginSheet:confirmUninstallSheet
	   modalForWindow:[self window]
		modalDelegate:self
	   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
		  contextInfo:nil];
}

- (IBAction)cancelUninstall:(id)sender;
{
    [confirmUninstallSheet orderOut:sender];
    
    [NSApp endSheet:confirmUninstallSheet returnCode:0];
}

- (IBAction)approveUninstall:(id)sender;
{
    [confirmUninstallSheet orderOut:sender];
    
    [NSApp endSheet:confirmUninstallSheet returnCode:1];
}

- (void)sheetDidEnd:(NSWindow *)sheet
		 returnCode:(int)returnCode
		contextInfo:(void *)contextInfo;
{
	if (returnCode == 1) {
		NSString *userPluginPath = [@"~/Library/Internet Plug-ins/ClickToFlash.webplugin" stringByExpandingTildeInPath];
		BOOL isDirectory = NO;
		BOOL userPluginExists = [[NSFileManager defaultManager] fileExistsAtPath:userPluginPath
																	 isDirectory:&isDirectory];
		BOOL succeeded = NO;
		if (userPluginExists && isDirectory) {
			// we'll move the plugin to the trash, instead of just obstinately
			// deleting it
			succeeded = [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation
																	 source:[@"~/Library/Internet Plug-ins/" stringByExpandingTildeInPath]
																destination:nil
																	  files:[NSArray arrayWithObject:@"ClickToFlash.webplugin"]
																		tag:nil];
		}
		
		if (succeeded) {
			[NSApp beginSheet:successfulUninstallationSheet
			   modalForWindow:[self window]
				modalDelegate:self
			   didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
				  contextInfo:nil];
		} else {
			// there are three ways to get here:
			
			// 1. either userPluginExists equals NO, in which case the plugin is
			// installed for all users and we can't guarantee that we can
			// uninstall it, so we'll just fail
			
			// 2. an item exists at the correct path, but it's a file not a
			// folder, so it's not ClickToFlash
			
			// 3. the plugin exists, but for some reason we couldn't move
			// it to the trash
			
			[NSApp beginSheet:failedUninstallationSheet
			   modalForWindow:[self window]
				modalDelegate:self
			   didEndSelector:@selector(resultSheetDidEnd:returnCode:contextInfo:)
				  contextInfo:nil];
		}
	} else {
		// uninstallation was cancelled
	}
}

- (IBAction)dismissSuccessSheet:(id)sender;
{
	[successfulUninstallationSheet orderOut:sender];
    
    [NSApp endSheet:successfulUninstallationSheet returnCode:0];
}

- (IBAction)dismissFailureSheet:(id)sender;
{
	[failedUninstallationSheet orderOut:sender];
    
    [NSApp endSheet:failedUninstallationSheet returnCode:0];
}

- (void)returnSheetDidEnd:(NSWindow *)sheet
		 returnCode:(int)returnCode
		contextInfo:(void *)contextInfo;
{
	// nothing to see here!
}

@end
