#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIAlertView (ShowMessage)

+ (void)showMessage:(NSString*)message;
+ (void)showNoInternetConnectionMessage:(NSString*)noInternetConnectionMessage;
+ (void)showMessage:(NSString*)message withTitle:(NSString*)title;

@end