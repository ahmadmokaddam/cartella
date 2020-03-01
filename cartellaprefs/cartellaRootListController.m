#include "cartellaRootListController.h"
#import <spawn.h>

//Not my UI design. I think I will be using this format for my tweak prefs from
//now on. It's kinda nice, ngl.

//UIColor *mainColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];
//UIColor *secondaryColor = [UIColor colorWithRed:0.04 green:0.37 blue:0.68 alpha:1.0];
NSString *tweakName = @"Cartella";

@implementation cartellaRootListController


- (instancetype)init
{
	self = [super init];

	self.showHeader = YES;

	return self;
}
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated {

	[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[self.class]].tintColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];
    [[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]] setOnTintColor:[UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0]];
    [[UISlider appearanceWhenContainedInInstancesOfClasses:@[self.class]] setTintColor:[UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0]];

    [super viewWillAppear:animated];


	if (!self.showHeader) return;

	self.navigationController.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];

	//[self scrollViewDidScroll:self.scrollView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];


	if (!self.showHeader) return;

	self.navigationController.navigationController.navigationBar.translucent = YES;
	//self.navigationController.navigationBar.tintColor = [UIColor systemBlueColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


	if (!self.showHeader) return;

    self.navigationController.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];
}
- (void)viewDidLoad
{
	[super viewDidLoad];
	// [UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0];
	if (!self.showHeader) return;

	self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring"
								style:UIBarButtonItemStylePlain
								target:self
								action:@selector(respring:)];
	self.respringButton.tintColor = [UIColor colorWithRed:0.04 green:0.74 blue:0.89 alpha:1.0];
	self.navigationItem.rightBarButtonItem = self.respringButton;

	self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/CartellaPrefs.bundle/icon@3x.png"]];
	self.iconView.contentMode = UIViewContentModeScaleAspectFit;
	self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
	self.iconView.alpha = 1.0;
	self.navigationItem.titleView = self.iconView;

	self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,280,[[UIScreen mainScreen] bounds].size.width, 100)];
	self.headerView.backgroundColor = [UIColor colorWithRed:0.04 green:0.37 blue:0.68 alpha:1.0];

	UILabel *tweakLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, [[UIScreen mainScreen] bounds].size.width, 30)];
	tweakLabel.font=[UIFont boldSystemFontOfSize:28];
	tweakLabel.textColor = [UIColor whiteColor];
	tweakLabel.text = tweakName;
	[self.headerView addSubview:tweakLabel];

	UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 200, 10)];
	authorLabel.font=[UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
	authorLabel.textColor = [UIColor whiteColor];
	authorLabel.text = @"by Burrit0z";
	[self.headerView addSubview:authorLabel];

	//[self.view addSubview:self.headerView];
	//[self.view sendSubviewToBack:self.headerView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (!self.showHeader) return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, 170)];
	if (!self.overflowView)
	{
		self.overflowView = [[UIView alloc] initWithFrame:CGRectMake(0,-310,[[UIScreen mainScreen] bounds].size.width,480)];
		self.overflowView.backgroundColor = [UIColor colorWithRed:0.04 green:0.37 blue:0.68 alpha:1.0];;
		CAGradientLayer *gradient = [CAGradientLayer layer];

		gradient.frame = self.overflowView.bounds;
		gradient.colors = @[(id)[UIColor colorWithRed:0.04 green:0.37 blue:0.68 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.04 green:0.37 blue:0.68 alpha:1.0].CGColor];

		[self.overflowView.layer insertSublayer:gradient atIndex:0];
		[self.overflowView addSubview:self.headerView];
		[tableView addSubview:self.overflowView];
	}

	//[tableView setContentInset:UIEdgeInsetsMake(150+tableView.contentInset.top, 0, 0, 0)];
	//self.automaticallyAdjustsScrollViewInsets = false;
	if (!self.startContentOffset) self.startContentOffset = tableView.contentOffset.y;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (!self.showHeader) return;
    CGFloat offsetY = scrollView.contentOffset.y;
	if (!self.kick)
		{
			self.kick = YES;
			offsetY = self.startContentOffset;
		}
	if (offsetY < 200 - self.startContentOffset) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 1.0;
        }];
    }
	if (offsetY > self.startContentOffset) return;
	CGFloat height = 250 + (offsetY - self.startContentOffset);
	CGFloat desiredY = 0.35 * height;
	self.headerView.subviews[0].frame = CGRectMake(15, desiredY, 100, 50);
	CGFloat aheight = 230 + ((offsetY - self.startContentOffset)/4);
	CGFloat adesiredY = 0.60 * aheight;
	self.headerView.subviews[1].frame = CGRectMake(15, adesiredY, 300, 50);
}
////////////

- (void)respring:(id)sender {
	  pid_t pid;
    const char* args[] = {"killall", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(void)apply:(PSSpecifier *)specifier {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.burritoz.cartella/reload"), nil, nil, true);
		 });
	 }

@end
