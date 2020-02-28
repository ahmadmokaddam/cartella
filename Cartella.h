//Created February 2020 by burrit0z

NSString *packageVersion = @"0.5.0.3";
BOOL updateAvailable = NO;
BOOL didShowAlert = NO;

@interface SBIconController : UIViewController
@end

@interface SBIconListGridLayoutConfiguration
@property (nonatomic, assign) NSString *isFolder;

- (NSString *)getLocations;
- (NSUInteger)numberOfPortraitColumns;
- (NSUInteger)numberOfPortraitRows;
@end

@interface SBFolderControllerBackgroundView : UIView
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat aplha;
-(void)layoutSubviews;
@end

//DO NOT USE THESE NEXT TWO INTERFACES, THEY ARE MOSTLY INACCURATE
@interface SBWallpaperEffectView : UIView
@property (nonatomic, retain) UIView *blurView;
@end

@interface SBFolderIconImageView : UIView
@property (nonatomic, retain) SBWallpaperEffectView *backgroundView; //This isn't really what the headers say...
@property (nonatomic, assign) CGFloat aplha;
@property (nonatomic, assign) CGAffineTransform transform;
@end

//////////////////

@interface SBIconListPageControl : UIView
@property (nonatomic, assign) BOOL hidden;
@end

@interface _SBIconGridWrapperView : UIView
@property (nonatomic, assign) CGAffineTransform transform;
@end

@interface UITextFieldBorderView
@property (nonatomic, assign) BOOL hidden;
-(void)layoutSubviews;
@end

@class UITextField, UIFont;
@interface SBFolderTitleTextField : UITextField
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, strong) UIFont *font;
-(void)setFont:(id)arg1 fullFontSize:(id)arg2 ambientOnly:(BOOL)arg3;
-(void)setTextCentersHorizontally:(BOOL)arg1;
-(void)layoutSubviews;
@end

BOOL shouldHide = NO;

BOOL cozyBadgesInstalled = NO;

BOOL tweakEnabled;
BOOL hideIconBackground;
BOOL hideFolderBackground;
BOOL hideLabels;
BOOL hideDots;
BOOL boldersLook;
BOOL fullScreen;
BOOL isNotchedDevice;
BOOL noBlur;
BOOL blackOut;
BOOL boldText;
BOOL titleAffectedTop;
BOOL shouldFolderIconColor;
BOOl shouldFolderBackgroundViewColor;

NSInteger closeByOption;
NSInteger folderRows;
NSInteger folderColumns;
NSInteger titleStyle;
NSInteger textAlignment;
double topOffset;
double sideOffset;
double additionalTitleMovement;
double cachedTopOffset;
double cachedSideOffset;
double setFolderIconSize;

double iconRed;
double iconGreen;
double iconBlue;
double iconAlpha;

double folderBackgroundViewRed;
double folderBackgroundViewGreen;
double folderBackgroundViewBlue;
double folderBackgroundViewAlpha;


HBPreferences *preferences;
