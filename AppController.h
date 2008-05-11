#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
	IBOutlet NSTextField	*name;
	IBOutlet NSTextField	*package;
	IBOutlet NSTextField	*version;
	IBOutlet NSTextField	*size;
	IBOutlet NSTextField	*website;
	IBOutlet NSTextField	*icon;
	IBOutlet NSTextField	*maintainer;
	IBOutlet NSTextField	*depends;
	IBOutlet NSTextField	*conflicts;
	IBOutlet NSTextField	*description;
	IBOutlet NSComboBox		*section;
	IBOutlet NSTextField	*files;
	IBOutlet NSButton		*browse;
	IBOutlet NSButton		*build;
	IBOutlet NSButton		*preinst;		
	IBOutlet NSButton		*postinst;			
	IBOutlet NSButton		*prerm; 
	IBOutlet NSButton		*postrm;
	IBOutlet NSTextView		*preinstbox;	
	IBOutlet NSScrollView	*preinstboxView;
	IBOutlet NSTextView		*postinstbox;	
	IBOutlet NSScrollView	*postinstboxView;
	IBOutlet NSTextView		*prermbox;		
	IBOutlet NSScrollView	*prermboxView;
	IBOutlet NSTextView		*postrmbox;		
	IBOutlet NSScrollView	*postrmboxView;
	IBOutlet NSWindow		*window;
}
NSDictionary *attribs;
- (IBAction) browse:(id)sender;
- (IBAction) clearText:(id)sender;
- (IBAction) saveText:(id)sender;
- (IBAction) build:(id)sender;

@end