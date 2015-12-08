//
//  ___PACKAGENAME___.m
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___PACKAGENAME___.h"

@interface ___PACKAGENAME___()
@end


@implementation ___PACKAGENAME___

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    // Load only into Xcode
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    if (![identifier isEqualToString:@"com.apple.dt.Xcode"]) {
        return;
    }
    
    [self sharedPlugin];
}


+ (instancetype)sharedPlugin
{
    static ___PACKAGENAME___ *_sharedPlugin;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlugin = [[self alloc] init];
    });
    
    return _sharedPlugin;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:nil];
    }
    
    return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    [self addPluginsMenu];
}


- (void)addPluginsMenu
{
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Do Action" action:@selector(doMenuAction) keyEquivalent:@""];
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
}


- (void)doMenuAction
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Hello, World!"];
    [alert runModal];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
