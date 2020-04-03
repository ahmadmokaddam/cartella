#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <CepheiPrefs/HBPackageNameHeaderCell.h>
#import <CepheiPrefs/HBLinkTableCell.h>
#import <Cephei/HBRespringController.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSListItemsController.h>
#import <spawn.h>

@interface cartellaSubPrefsRootListController : HBRootListController{
    UITableView * _table;
}
//krit's stuff (thanks)
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *overflowView;
@property (nonatomic, assign) CGFloat startContentOffset;
@property (nonatomic, assign) BOOL kick;
@property (nonatomic, assign) BOOL showHeader;

@property (nonatomic, retain) UIBarButtonItem *respringButton;
@property (nonatomic, retain) UIImageView *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;

@end

//I know this isn't a root list controller. Sorry, I'm lazy. It doesn't impair
//the functionality or effeciency, so I'm good with it
