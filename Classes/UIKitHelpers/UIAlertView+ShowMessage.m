#import "UIAlertView+ShowMessage.h"

@implementation UIAlertView (ShowMessage)

+ (void)showMessage:(NSString*)message withTitle:(NSString*)title
{
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title 
                                                      message: message
                                                     delegate: nil
                                            cancelButtonTitle: @"Ok"
                                            otherButtonTitles: nil];
  
  [alertView show];
  
  [alertView release];
}

+ (void)showMessage:(NSString*)message
{
  [self showMessage: message withTitle: @""];
}

+ (void)showNoInternetConnectionMessage:(NSString*)noInternetConnectionMessage
{
  [self showMessage: noInternetConnectionMessage withTitle: @"No Internet Connection :("];
}

@end