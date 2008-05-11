#import "AppController.h"
@implementation AppController
- (void)awakeFromNib {
	attribs = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSNumber alloc] initWithInt:0755], NSFilePosixPermissions, nil];
}
- (IBAction) browse:(id)sender {
	NSOpenPanel *op = [NSOpenPanel openPanel]; int iResult; [op setCanChooseDirectories : YES ]; [op setCanChooseFiles : NO ]; iResult = [ op runModalForDirectory : NSHomeDirectory () file: nil types: nil]; if (iResult == NSOKButton) [files setStringValue: [op filename] ];
	[[NSFileManager defaultManager] removeItemAtPath:[[NSString alloc] initWithFormat:@"%@/DEBIAN", [files stringValue]] error:NULL]; [[NSFileManager defaultManager] createDirectoryAtPath:[[NSString alloc] initWithFormat:@"%@/DEBIAN", [files stringValue]] attributes:attribs];
}
- (IBAction) clearText:(id)sender {
	switch ([sender tag]) {
		case 1: [preinstbox setString:@"#!/bin/bash\n"]; break;
		case 2: [postinstbox setString:@"#!/bin/bash\n"]; break;
		case 3: [prermbox setString:@"#!/bin/bash\n"]; break;
		case 4: [postrmbox setString:@"#!/bin/bash\n"]; break;
	}
}
- (IBAction) saveText:(id)sender {
	[[NSFileManager defaultManager] createDirectoryAtPath:[[NSString alloc] initWithFormat:@"%@/DEBIAN", [files stringValue]] attributes:attribs]; NSString *saveFile; NSString *file;
	switch ([sender tag]) {
		case 1: saveFile = [[NSString alloc] initWithString:[preinstbox string]]; file = [[NSString alloc] initWithFormat:@"%@/DEBIAN/preinst", [files stringValue]]; break;
		case 2: saveFile = [[NSString alloc] initWithString:[postinstbox string]]; file = [[NSString alloc] initWithFormat:@"%@/DEBIAN/postinst", [files stringValue]]; break;
		case 3: saveFile = [[NSString alloc] initWithString:[prermbox string]]; file = [[NSString alloc] initWithFormat:@"%@/DEBIAN/prerm", [files stringValue]]; break;
		case 4: saveFile = [[NSString alloc] initWithString:[postrmbox string]]; file = [[NSString alloc] initWithFormat:@"%@/DEBIAN/postrm", [files stringValue]]; break;
	} [saveFile writeToFile:file atomically:NO encoding:NSUTF8StringEncoding error:NULL]; [[NSFileManager defaultManager] setAttributes:attribs ofItemAtPath:file error:NULL];
}
- (IBAction) build:(id)sender {
	NSString *control = [[NSString alloc] initWithString:@"Architecture: darwin-arm\n"];
	NSString *nameString = [[NSString alloc] initWithFormat:@"Name: %@\n", [name stringValue]]; if (![[name stringValue] isEqualToString:@""]) control = [control stringByAppendingString:nameString];
	NSString *packageString = [[NSString alloc] initWithFormat:@"Package: %@\n", [package stringValue]]; if (![[package stringValue] isEqualToString:@""]) control = [control stringByAppendingString:packageString];
	NSString *versionString = [[NSString alloc] initWithFormat:@"Version: %@\n", [version stringValue]]; if (![[version stringValue] isEqualToString:@""]) control = [control stringByAppendingString:versionString];
	NSString *sizeString = [[NSString alloc] initWithFormat:@"Size: %@\n", [size stringValue]]; if (![[size stringValue] isEqualToString:@""]) control = [control stringByAppendingString:sizeString];
	NSString *websiteString = [[NSString alloc] initWithFormat:@"Website: %@\n", [website stringValue]]; if (![[website stringValue] isEqualToString:@""]) control = [control stringByAppendingString:websiteString];
	NSString *iconString = [[NSString alloc] initWithFormat:@"Icon: %@\n", [icon stringValue]]; if (![[icon stringValue] isEqualToString:@""]) control = [control stringByAppendingString:iconString];
	NSString *maintainerString = [[NSString alloc] initWithFormat:@"Maintainer: %@\n", [maintainer stringValue]]; if (![[maintainer stringValue] isEqualToString:@""]) control = [control stringByAppendingString:maintainerString];
	NSString *dependsString = [[NSString alloc] initWithFormat:@"Depends: %@\n", [depends stringValue]]; if (![[depends stringValue] isEqualToString:@""]) control = [control stringByAppendingString:dependsString];
	NSString *conflictsString = [[NSString alloc] initWithFormat:@"Conflicts: %@\n", [conflicts stringValue]]; if (![[conflicts stringValue] isEqualToString:@""]) control = [control stringByAppendingString:conflictsString];
	NSString *descriptionString = [[NSString alloc] initWithFormat:@"Description: %@\n", [description stringValue]]; if (![[description stringValue] isEqualToString:@""]) control = [control stringByAppendingString:descriptionString];
	NSString *sectionString = [[NSString alloc] initWithFormat:@"Section: %@\n", [section stringValue]]; if (![[section stringValue] isEqualToString:@""]) control = [control stringByAppendingString:sectionString];
	[control writeToFile:[[NSString alloc] initWithFormat:@"%@/DEBIAN/control", [files stringValue]] atomically: NO encoding:NSUTF8StringEncoding error:NULL];
	NSTask *task = [[[NSTask alloc] init] autorelease]; [task setArguments:[NSArray arrayWithObjects:@"-b", [files stringValue], nil]]; [task setLaunchPath:[[NSBundle mainBundle] pathForResource:@"dpkg-deb" ofType:nil]]; [task launch];
}
@end
