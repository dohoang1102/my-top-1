#import <UIKit/UIKit.h>

@class MyTop1ViewController;

@interface MyTop1AppDelegate : NSObject <UIApplicationDelegate> 
{
  UIWindow *window;
  MyTop1ViewController *viewController;
}

@property(nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, retain) IBOutlet MyTop1ViewController *viewController;

@end