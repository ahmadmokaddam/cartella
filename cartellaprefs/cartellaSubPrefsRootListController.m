#include "cartellaSubPrefsRootListController.h"

//I know this isn't a root controller, i'm too lazy to rename

@implementation cartellaSubPrefsRootListController

-(void)respring:(PSSpecifier *)specifier {
		PSTableCell *cell = [self cachedCellForSpecifier:specifier];
    cell.cellEnabled = NO;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[HBRespringController respring];
		});
	}

	- (id)specifiers {
    return _specifiers;
}

- (void)loadFromSpecifier:(PSSpecifier *)specifier {
    NSString *sub = [specifier propertyForKey:@"subPage"];

    _specifiers = [self loadSpecifiersFromPlistName:sub target:self];
}

- (void)setSpecifier:(PSSpecifier *)specifier {
    [self loadFromSpecifier:specifier];
    [super setSpecifier:specifier];
}

- (bool)shouldReloadSpecifiersOnResume {
    return false;
}

-(void)apply:(PSSpecifier *)specifier {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.burritoz.cartella/reload"), nil, nil, true);
		 });
	 }

@end
