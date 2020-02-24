#include "cartellaRootListController.h"

@implementation cartellaRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)respring:(PSSpecifier *)specifier {
		PSTableCell *cell = [self cachedCellForSpecifier:specifier];
    cell.cellEnabled = NO;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[HBRespringController respring];
		});
	}

-(void)apply:(PSSpecifier *)specifier {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.burritoz.cartella/reload"), nil, nil, true);
		 });
	 }

@end
