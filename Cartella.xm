@interface SBIconController : UIAlertController
+(id)sharedInstance;
@end
BOOL didShowAlert = NO;

%hook SBIconController

-(void)viewDidAppear:(BOOL)arg1 {
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attention, Cartella user"
                               message:@"Hello, thanks for downloading and using Cartella! At this time, Cartella is now deprecated. Cartella is replaced with a new, much more feature rich and less buggy tweak called Folded. It is available on Packix for FREE! \n \n Thanks for understanding this sudden and abrupt deprecation. if you would like, you can still downgrade Cartella to the latest non-EOL version. \n \n Trust me, you'll like Folded more!"
                               preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault
   		handler:^(UIAlertAction * action) {}];

		[alert addAction:defaultAction];
  if(!didShowAlert) {
    [self presentViewController:alert animated:YES completion:nil];
    didShowAlert = YES;
  }
}

%end