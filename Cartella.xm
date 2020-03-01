//I needed some more practice, so heres (kinda, not really anymore) simple but
//fun tweak! Cartella means Folder in Italian.
//A huge thanks to developers of awesome tweaks like Dayn, they motivate me to
//learn to code!

//I use layoutSubviews a lot here, I read that it was not the most optimal way
//of doing things, but I don't know what would be better in this case.

//If you have any optimization sugestions, or just sugestions in general, please
//do give them. (I annotate my code to explain my reasons for doing things)

#import <Cephei/HBPreferences.h> //Sorry if you don't like Cephei
#import "Cartella.h"

%group labelHandling

%hook SBIconLegibilityLabelView
- (void)setHidden:(BOOL)arg1 {
  if (hideLabels) {
    %orig(YES); //If this is toggled, will return YES.
  }
}
%end

%end

%group UniversalCode

%hook SBFloatyFolderView //Nothing that libFLEX can't find!
-(void)setBackgroundAlpha:(CGFloat)arg1 {
  if (hideFolderBackground) {
    %orig(0.0);
  } else {
    return (%orig);
  }
}

-(BOOL)_tapToCloseGestureRecognizer:(id)arg1 shouldReceiveTouch:(id)arg2 {
  %orig;
  if ((closeByOption == 2) || (closeByOption == 0)) {
    return (YES);
  } else {
    return %orig;
  }
}

%end

%hook SBFolderController
-(BOOL)_homescreenAndDockShouldFade {
  if (boldersLook) {
    return YES;
  } else {
    return %orig;
  }
}
%end

%end

%group iOS13

%hook SBIconListGridLayoutConfiguration

%property (nonatomic, assign) NSString *isFolder; //I'll make this a BOOL when I'm not lazy.

%new
-(NSString *)getLocations {
  //Let's first check to make sure "isFolder" hasn't been set (so no loops)
  if (self.isFolder != nil) {
    return self.isFolder;
  }
  //This is based on kritanta's method, but slightly different so home plus can work with Cartella
  //Ok, lets see. The iphonedevwiki says this is the format for MSHookIvar:
  //type ivar = MSHookIvar<type>(object, ivar_name);
  NSUInteger locationColumns = MSHookIvar<NSUInteger>(self, "_numberOfPortraitColumns");
  NSUInteger locationRows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
  //Now we can use logic to figure out if its in a folder.
  if (locationColumns == 3 && locationRows == 3) {
    self.isFolder = @"YES"; //I'm pretty sure I SHOULD use the @, its an objc string. Also, I should use a bool.
  } else {
    self.isFolder = @"NO";
  }
  return self.isFolder;
} //Very similar to what I did in dockify.

-(NSUInteger)numberOfPortraitColumns {
  [self getLocations];
  if ([self.isFolder isEqualToString:@"YES"]) {
    return (folderColumns);
  } else {
    return (%orig);
  }
}

-(NSUInteger)numberOfPortraitRows {
  [self getLocations];
  if ([self.isFolder isEqualToString:@"YES"]) {
    return (folderRows);
  } else {
    return (%orig);
  }
}

- (UIEdgeInsets)portraitLayoutInsets {
  [self getLocations];
  if (fullScreen && hideFolderBackground) {
    if ([self.isFolder isEqualToString:@"YES"]) {
      UIEdgeInsets original = %orig;
      return UIEdgeInsetsMake(
        (original.top + 50),
        (original.left/2), //no sense in wasting space if the background is hidden, so it won't look ugly.
        (original.bottom - 50),
        (original.right/2)
      );
    } else {
      return (%orig);
    }
  } else {
    return (%orig);
  }
}

%end

%hook SBHFloatyFolderVisualConfiguration

-(CGSize)contentBackgroundSize {
  if (fullScreen) { //So we don't adjust anything if it's not set to fullScreen
    return CGSizeMake(
      (([[UIScreen mainScreen] bounds].size.width - 20) - sideOffset),
      (([[UIScreen mainScreen] bounds].size.height - 220) - topOffset)
    );
  } else {
    return (%orig);
  }
}

-(CGFloat)continuousCornerRadius {
  if (customRadius) {
    return (setCustomRadius);
  } else if (fullScreen && hideFolderBackground) {
    return 0;
  } else {
    return %orig;
  }
}

%end
%hook SBFolderTitleTextField

-(void)layoutSubviews {
  %orig;
  if (boldText) {
    UIFont *regular = self.font;
    self.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:(regular.pointSize)];
    //Bolders used HelveticaNeue, so it looks exactly like Bolders did!
    //I had to look at UIFont.h to find the property pointSize (it's a CGFloat)
  }
}

-(void)setFontSize:(double)arg1 {
  if (textAlignment != 1) { //doing this here instead of layoutSubviews
    [self setTextCentersHorizontally:NO];
    if (textAlignment != 0) {
      [self setTextAlignment:textAlignment];
    }
  }
  if (titleStyle == 1) {
    %orig(55);
  } else if (titleStyle == 2) {
    %orig(0);
  } else {
    %orig(40); //That's slightly more than the 36 iOS default.
  }
}

-(CGRect)textRectForBounds:(CGRect)arg1 {
  CGRect original = %orig;
  //This next part is a whole lot of proportions and mathsss
  double titletopOffset = (((titleAffectedTop) ? topOffset : 0) + additionalTitleMovement);
  if (fullScreen && isNotchedDevice) {
    return CGRectMake(
      ((original.origin.x * 0.14) - (sideOffset/2)),
      // I use (sideOffset/2) because the side pinch factor decreases the folder
      //box by sideOffset/2 on each side (left and right, the folder is pinned
      //in the center) The size of the folder box determines the text rect x
      //position, so I make sure to keep it pinned to the side anyways.
      ((titleStyle == 1) ? (titletopOffset - 25) : (titletopOffset - 15)),
      (original.size.width + (original.origin.x * 1.73)),
      //Don't make me explain this math
      (original.size.height)
    );
  } else if (fullScreen && (!isNotchedDevice)) {
    return CGRectMake(
      ((original.origin.x * 0.14) - (sideOffset/2)),
      ((titleStyle == 1) ? (titletopOffset - 80) : (titletopOffset - 60)), //this should fix things
      (original.size.width + (original.origin.x * 1.73)),
      (original.size.height)
    );
  } else {
    return CGRectMake(
      ((original.origin.x * 0.14) + 10),
      (original.origin.y + 100),
      (original.size.width + 40),
      (original.size.height)
    );
  }
}

%end

%hook UITextFieldBorderView //it seems this is for the edit folder text only, I hope so.
-(void)layoutSubviews {
  %orig;
  self.hidden = 1;
}
%end

%hook SBFolderControllerBackgroundView

//I'm only using layoutSubviews because its how I was taught, is easy, and will
//be easy for others to understand when they are reading my code.

-(void)layoutSubviews {
  if (shouldFolderBackgroundViewColor) {
    self.backgroundColor = [UIColor colorWithRed:folderBackgroundViewRed green:folderBackgroundViewGreen blue:folderBackgroundViewBlue alpha:folderBackgroundViewAlpha];
  } else if (blackOut) {
    self.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
  } else {
    %orig;
    self.alpha = setBlur;
  }
}

%end

%hook SBHFolderSettings

-(BOOL)pinchToClose {
  return (((closeByOption == 1) || (closeByOption == 0)) ? YES : (%orig));
}

%end

%hook SBFolderIconImageView

-(void)layoutSubviews { //I'm sorry for using layoutSubviews, there's probably a better way
  %orig; //I want to run the original stuff first
  if (shouldFolderIconColor) {
    self.backgroundView.blurView.hidden = 1;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:iconRed green:iconGreen blue:iconBlue alpha:iconAlpha];
  }
  if (hideIconBackground) {
    self.backgroundView.blurView.hidden = 1;
    self.backgroundView.alpha = 0;
    self.backgroundView.hidden = 1;
  }
}

%end

%hook _SBIconGridWrapperView
//This is the folder icon... but the provider for the grid image only.
//This doesn't include the blur

-(void)layoutSubviews { //Tell me if there's a better way, please.
  %orig;
  CGAffineTransform originalIconView = (self.transform);
  self.transform = CGAffineTransformMake(
    setFolderIconSize,
    originalIconView.b,
    originalIconView.c,
    setFolderIconSize,
    originalIconView.tx,
    originalIconView.ty
  );
}

%end

%hook SBIconListPageControl

-(void)layoutSubviews {
  %orig;
  if (hideDots) {
    self.hidden = 1;
  }
}

%end
%end

%group iOS12 //There (mostly) isn't iOS 12 support, so I don't know why I include this stuff

%hook SBIconBlurryBackgroundView

-(BOOL)isBlurring {
  if (hideIconBackground) {
    return NO;
  } else {
    return %orig;
  }
}

%end

%hook SBFolderIconListView
+(unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 {
  return (folderColumns);
}

+(NSUInteger)maxVisibleIconRowsInterfaceOrientation:(NSInteger)arg1 {
  return (folderRows);
}
%end

%end

static void reloadDynamics() { //This is called when the user selects the
                               //"Apply Dynamically" option in settings
  shouldFolderIconColor = [preferences boolForKey:@"shouldFolderIconColor"];
  shouldFolderBackgroundViewColor = [preferences boolForKey:@"shouldFolderBackgroundViewColor"];
  iconRed = [preferences doubleForKey:@"iconRed"];
  iconBlue = [preferences doubleForKey:@"iconBlue"];
  iconGreen = [preferences doubleForKey:@"iconGreen"];
  iconAlpha = [preferences doubleForKey:@"iconAlpha"];

  folderBackgroundViewRed = [preferences doubleForKey:@"folderBackgroundViewRed"];
  folderBackgroundViewGreen = [preferences doubleForKey:@"folderBackgroundViewGreen"];
  folderBackgroundViewBlue = [preferences doubleForKey:@"folderBackgroundViewBlue"];
  folderBackgroundViewAlpha = [preferences doubleForKey:@"folderBackgroundViewAlpha"];

  customRadius = [preferences boolForKey:@"customRadius"];
  setCustomRadius = [preferences doubleForKey:@"setCustomRadius"];

  boldText = [preferences boolForKey:@"boldText"];
  setFolderIconSize = [preferences doubleForKey:@"setFolderIconSize"];
  hideIconBackground = [preferences boolForKey:@"hideIconBackground"];
  hideFolderBackground = [preferences boolForKey:@"hideFolderBackground"];
  boldersLook = [preferences boolForKey:@"boldersLook"];
  closeByOption = [preferences integerForKey:@"closeByOption"];
  blackOut = [preferences boolForKey:@"blackOut"];
  setBlur = [preferences doubleForKey:@"setBlur"];

  if (fullScreen && (([preferences boolForKey:@"fullScreen"]) == NO)) {
    [preferences setDouble:([preferences doubleForKey:@"sideOffset"]) forKey:@"cachedSideOffset"];
    [preferences setDouble:([preferences doubleForKey:@"topOffset"]) forKey:@"cachedTopOffset"];

    [preferences setDouble:0 forKey:@"topOffset"];
    [preferences setDouble:0 forKey:@"sideOffset"];
  }
  if (!fullScreen && (([preferences boolForKey:@"fullScreen"]) == YES)) {
    [preferences setDouble:([preferences doubleForKey:@"cachedSideOffset"]) forKey:@"sideOffset"];
    [preferences setDouble:([preferences doubleForKey:@"cachedTopOffset"]) forKey:@"topOffset"];
  }

  fullScreen = [preferences boolForKey:@"fullScreen"];
  isNotchedDevice = [preferences boolForKey:@"isNotchedDevice"];
  sideOffset = [preferences doubleForKey:@"sideOffset"];
  topOffset = [preferences doubleForKey:@"topOffset"];
  titleStyle = [preferences integerForKey:@"titleStyle"];
  textAlignment = [preferences integerForKey:@"textAlignment"];
  titleAffectedTop = [preferences boolForKey:@"titleAffectedTop"];
  additionalTitleMovement = [preferences doubleForKey:@"additionalTitleMovement"];
}

%ctor {
  //Lol this next part also helps those with pirated versions of this tweak :P
  //  ¯\_(ツ)_/¯

  cozyBadgesInstalled = ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/CozyBadges.dylib"]) ? YES : NO;

  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadDynamics, CFSTR("com.burritoz.cartella/reload"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

  preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.cartellaprefs"];
  [preferences registerDefaults:@ { //defaults for prefernces
		@"tweakEnabled" : @YES,
    @"hideLabels" : @NO,
    @"hideIconBackground" : @NO,
    @"hideFolderBackground" : @YES,
    @"folderRows" : @3,
    @"folderColumns" : @4,
    @"titleStyle" : @1,
    @"fullScreen" : @YES,
    @"closeByOption" : @3,
    @"topOffset" : @0,
    @"sideOffset" : @0,
    @"cachedTopOffset" : @0,
    @"cachedSideOffset" : @0,
    @"boldersLook" : @YES,
    @"setIconSize" : @NO,
    @"isNotchedDevice" : @YES,
    @"setBlur" : @0,
    @"blackOut" : @NO,
    @"setFolderIconSize" : @1,
    @"hideDots" : @NO,
    @"textAlignment" : @1,
    @"boldText" : @YES,
    @"titleAffectedTop" : @YES,
    @"additionalTitleMovement" : @0,
    @"customRadius" : @NO,
	}];

	[preferences registerBool:&customRadius default:NO forKey:@"customRadius"];
  [preferences registerBool:&tweakEnabled default:YES forKey:@"tweakEnabled"];
  [preferences registerBool:&isNotchedDevice default:YES forKey:@"isNotchedDevice"];
  [preferences registerBool:&boldText default:YES forKey:@"boldText"];
  [preferences registerBool:&hideLabels default:NO forKey:@"hideLabels"];
  [preferences registerBool:&hideDots default:NO forKey:@"hideDots"];
  [preferences registerDouble:&setBlur default:0 forKey:@"setBlur"];
  [preferences registerBool:&blackOut default:NO forKey:@"blackOut"];
  [preferences registerBool:&hideIconBackground default:NO forKey:@"hideIconBackground"];
  [preferences registerBool:&hideFolderBackground default:YES forKey:@"hideFolderBackground"];
  [preferences registerBool:&titleAffectedTop default:YES forKey:@"titleAffectedTop"];
  [preferences registerInteger:&folderRows default:3 forKey:@"folderRows"];
  [preferences registerInteger:&folderColumns default:4 forKey:@"folderColumns"];
  [preferences registerInteger:&titleStyle default:1 forKey:@"titleStyle"];
  [preferences registerInteger:&textAlignment default:1 forKey:@"textAlignment"];
  [preferences registerBool:&boldersLook default:YES forKey:@"boldersLook"];
  [preferences registerBool:&fullScreen default:YES forKey:@"fullScreen"];
  [preferences registerInteger:&closeByOption default:3 forKey:@"closeByOption"];
  [preferences registerDouble:&topOffset default:0 forKey:@"topOffset"];
  [preferences registerDouble:&sideOffset default:0 forKey:@"sideOffset"];
  [preferences registerDouble:&additionalTitleMovement default:0 forKey:@"additionalTitleMovement"];
  //Becuase it resets to 0 when full screen is turned off, this keeps it stored
  [preferences registerDouble:&cachedTopOffset default:0 forKey:@"cachedTopOffset"];
  [preferences registerDouble:&cachedSideOffset default:0 forKey:@"cachedSideOffset"];

  [preferences registerDouble:&setFolderIconSize default:1 forKey:@"setFolderIconSize"];
  [preferences registerDouble:&setCustomRadius default:60 forKey:@"setCustomRadius"];

  [preferences registerBool:&shouldFolderIconColor default:NO forKey:@"shouldFolderIconColor"];
  [preferences registerDouble:&iconRed default:0 forKey:@"iconRed"];
  [preferences registerDouble:&iconGreen default:0 forKey:@"iconGreen"];
  [preferences registerDouble:&iconBlue default:0 forKey:@"iconBlue"];
  [preferences registerDouble:&iconAlpha default:0 forKey:@"iconAplha"]; //This is a prime example of bad naming

  [preferences registerBool:&shouldFolderBackgroundViewColor default:NO forKey:@"shouldFolderBackgroundViewColor"];
  [preferences registerDouble:&folderBackgroundViewRed default:0 forKey:@"folderBackgroundViewRed"];
  [preferences registerDouble:&folderBackgroundViewGreen default:0 forKey:@"folderBackgroundViewGreen"];
  [preferences registerDouble:&folderBackgroundViewBlue default:0 forKey:@"folderBackgroundViewBlue"];
  [preferences registerDouble:&folderBackgroundViewAlpha default:0 forKey:@"folderBackgroundViewAplha"];

  [preferences setDouble:([preferences doubleForKey:@"sideOffset"]) forKey:@"cachedSideOffset"];
  [preferences setDouble:([preferences doubleForKey:@"topOffset"]) forKey:@"cachedTopOffset"];

  if (!fullScreen) {
    //Because we don't adjust the folder background size otherwise
    [preferences setDouble:0 forKey:@"topOffset"];
    [preferences setDouble:0 forKey:@"sideOffset"];

    sideOffset = [preferences doubleForKey:@"sideOffset"];
    topOffset = [preferences doubleForKey:@"topOffset"];
  }

	if (tweakEnabled) { //That way my tweak doesn't load if it doesn't need to
    %init(UniversalCode);
    if (!cozyBadgesInstalled) {
      %init(labelHandling);
    }
    if (kCFCoreFoundationVersionNumber < 1600) {
      %init(iOS12); //There actually is not ios12 support, mostly
    } else {
      %init(iOS13);
    }
  }
}
