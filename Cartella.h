//Created February 2020 by burrit0z

#import <libcolorpicker.h>
UIColor *colorFromDefaultsWithKey(NSString *defaults, NSString *key, NSString *fallback);

@interface SBIconController : UIView
@end

@interface SBIconListGridLayoutConfiguration
@property (nonatomic, assign) BOOL isFolder;

- (BOOL)getLocations;
- (NSUInteger)numberOfPortraitColumns;
- (NSUInteger)numberOfPortraitRows;
@end

@interface SBIconGridImage
+(id)gridImageForLayout:(id)arg1 previousGridImage:(id)arg2 previousGridCellIndexToUpdate:(unsigned long long)arg3 pool:(id)arg4 cellImageDrawBlock:(id)arg5 ;
+(id)gridImageForLayout:(id)arg1 cellImageDrawBlock:(id)arg2 ;
+(id)gridImageForLayout:(id)arg1 pool:(id)arg2 cellImageDrawBlock:(id)arg3 ;
@end

/*
@interface SBIconListFlowLayout
- (NSUInteger)numberOfRowsForOrientation:(NSInteger)arg1;
- (NSUInteger)numberOfColumnsForOrientation:(NSInteger)arg1;
@end */

@interface SBFloatyFolderView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
@end

@interface SBFolderBackgroundView : UIView
-(void)layoutSubviews;
-(void)setBackgroundColor:(UIColor *)arg1;
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
BOOL blackOut;
BOOL boldText;
BOOL titleAffectedTop;
BOOL shouldFolderIconColor;
BOOL shouldFolderBackgroundViewColor;
BOOL shouldFolderBackgroundColor;
BOOL customRadius;

NSInteger closeByOption;

NSInteger folderRows;
NSInteger folderColumns;

NSInteger folderIconRows;
NSInteger folderIconColumns;
NSInteger titleStyle;
NSInteger textAlignment;
double topOffset;
double sideOffset;
double additionalTitleMovement;
double cachedTopOffset;
double cachedSideOffset;
double setFolderIconSizeA;
double setFolderIconSizeD;
double setCustomRadius;
double setBlur;
double dotMovement;

HBPreferences *preferences;

BOOL hasProcessLaunched;