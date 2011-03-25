#import "MyTop1AppDelegate.h"
#import "UIKitHelpers.h"

@implementation MyTop1AppDelegate

@synthesize window, viewController;

#pragma mark -
#pragma mark "Protected" methods

- (BOOL)mustResetFavoriteNumber
{ 
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults synchronize];
  
  return [defaults boolForKey: @"ResetFavoriteNumber"];
}

- (void)resetFavoriteNumber
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject: nil forKey: @"FavoriteNumber"];  
  [defaults setBool: NO forKey: @"ResetFavoriteNumber"];
  
  [defaults synchronize];
}

- (NSString *)favoriteNumber
{
  return [[NSUserDefaults standardUserDefaults] stringForKey: @"FavoriteNumber"];
}

- (void)showMyTop1View
{
  [self.window addSubview: self.viewController.view];
  [self.window makeKeyAndVisible];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{  
  if(![self favoriteNumber])
    [self showMyTop1View];

  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
  if([self mustResetFavoriteNumber])
  {
    if([[self.window subviews] count] == 0)
      [self showMyTop1View];
      
    viewController.instructionsLabel.text = 
      @"You haven't set your favorite person yet. Tap the button below to set it, and reset it on My Top 1 preferences on Settings app.";
    
    [viewController.setFavoritePersonButton setTitle: @"Set your favorite person" forState: UIControlStateNormal];
    
    [self resetFavoriteNumber];
  }
  
  if([self favoriteNumber])
    [Call toNumber: [self favoriteNumber]];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
  [self.viewController release];
  [self.window release];

  [super dealloc];
}

@end