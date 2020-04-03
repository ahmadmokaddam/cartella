#include "cartellaSubPrefsRootListController.h"
#import <spawn.h>
#import <libcolorpicker.h>
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

-(void)viewWillAppear:(BOOL)animated {
	[self reload];
	[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]].tintColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0]];

    [super viewWillAppear:animated];
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
		 PSTableCell *cell = [self cachedCellForSpecifier:specifier];
			cell.cellEnabled = NO;
		 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			 [HBRespringController respring];
		 });
	 }

@end
