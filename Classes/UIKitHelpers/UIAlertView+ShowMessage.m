#import "UIAlertView+ShowMessage.h"
#import "Messages.h"

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
  [self showMessage: noInternetConnectionMessage withTitle: NO_INTERNET_CONNECTION_MESSAGE];
}

@end