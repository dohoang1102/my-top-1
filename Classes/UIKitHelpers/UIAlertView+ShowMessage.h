#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (ShowMessage)

+ (void)showMessage:(NSString*)message;
+ (void)showNoInternetConnectionMessage:(NSString*)noInternetConnectionMessage;
+ (void)showMessage:(NSString*)message withTitle:(NSString*)title;

@end