#import "Call.h"
#import <UIKit/UIKit.h>
#import "UIAlertView+ShowMessage.h"
#import "Messages.h"

@implementation Call

+ (BOOL)toNumber:(NSString*)phoneNumber withErrorMessage:(NSString*)errorMessage andErrorTitle:(NSString*)errorTitle
{
  NSString *formatedPhoneNumber = [NSString stringWithFormat: @"tel:%@", phoneNumber];
  NSURL *phoneNumberURL = [NSURL URLWithString: formatedPhoneNumber];  
  
  if([[UIApplication sharedApplication] canOpenURL: phoneNumberURL])
    return [[UIApplication sharedApplication] openURL: phoneNumberURL];
  else
  {
    [UIAlertView showMessage: errorMessage withTitle: errorTitle];
    
    return NO;
  }
}

+ (BOOL)toNumber:(NSString*)phoneNumber
{
  return [Call toNumber: phoneNumber withErrorMessage: DEVICE_DONT_SUPPORT_PHONE_CALLS_MESSAGE
          andErrorTitle: DEVICE_DONT_SUPPORT_PHONE_CALLS_MESSAGE_TITLE];
}      

+ (BOOL)toNumber:(NSString*)phoneNumber withErrorMessage:(NSString*)errorMessage
{
  return [Call toNumber: phoneNumber withErrorMessage: errorMessage
          andErrorTitle: DEVICE_DONT_SUPPORT_PHONE_CALLS_MESSAGE_TITLE];
}

+ (BOOL)toNumber:(NSString*)phoneNumber withErrorTitle:(NSString*)errorTitle
{	 	
  return [Call toNumber: phoneNumber withErrorMessage: DEVICE_DONT_SUPPORT_PHONE_CALLS_MESSAGE_TITLE 
          andErrorTitle: errorTitle];
}

@end