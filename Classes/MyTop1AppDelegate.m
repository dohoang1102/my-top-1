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
  
  [defaults setObject: nil forKey:@"FavoriteNumber"];  
  [defaults setBool: NO forKey: @"ResetFavoriteNumber"];
  
  [defaults synchronize];
}

- (NSString *)favoriteNumber
{
  return [[NSUserDefaults standardUserDefaults] stringForKey: @"FavoriteNumber"];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
  // Override point for customization after application launch.  
  if(![self favoriteNumber])
  {
    // Add the view controller's view to the window and display.
    [self.window addSubview: viewController.view];
    [self.window makeKeyAndVisible];
  }  

  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
  if([self mustResetFavoriteNumber])
    [self resetFavoriteNumber];
  
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