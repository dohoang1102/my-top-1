#import <UIKit/UIKit.h>
#import "MyTop1ViewController.h"

@interface MyTop1AppDelegate : NSObject <UIApplicationDelegate> 
{
  IBOutlet UIWindow *window;
  IBOutlet MyTop1ViewController *viewController;
}

@property(nonatomic, retain) UIWindow *window;
@property(nonatomic, retain) MyTop1ViewController *viewController;

@end