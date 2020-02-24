//Created February 2020 by burrit0z

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

@interface SBFolderIconImageView : UIView
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, assign) CGFloat aplha;
@property (nonatomic, assign) CGAffineTransform transform;
@end

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

BOOL dpkgInvalid = NO;

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
NSInteger closeByOption;
NSInteger folderRows;
NSInteger folderColumns;
NSInteger titleStyle;
NSInteger textAlignment;
double topOffset;
double sideOffset;
double setFolderIconSize;


HBPreferences *preferences;
