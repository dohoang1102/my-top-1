#import "Call.h"
#import "UIAlertView+ShowMessage.h"

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
  return [Call toNumber: phoneNumber withErrorMessage: @"Sorry, but your device don't support phone calls." 
          andErrorTitle: @"Phone calls not supported :("];
}      

+ (BOOL)toNumber:(NSString*)phoneNumber withErrorMessage:(NSString*)errorMessage
{
  return [Call toNumber: phoneNumber withErrorMessage: errorMessage andErrorTitle: @"Phone calls not supported :("];
}

+ (BOOL)toNumber:(NSString*)phoneNumber withErrorTitle:(NSString*)errorTitle
{	 	
  return [Call toNumber: phoneNumber withErrorMessage: @"Sorry, but your device don't support phone calls." 
          andErrorTitle: errorTitle];
}

@end