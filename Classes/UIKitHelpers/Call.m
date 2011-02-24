#import "Call.h"

@implementation Call

- (BOOL)toNumber:(NSString *)phoneNumber
{
  NSString *phoneNumberURLFormat = [NSString stringWithFormat: @"tel:%@", phoneNumber];
  NSURL *phoneNumberURL = [NSURL URLWithString: phoneNumberURLFormat];
  
  return [[[UIApplication] sharedApplication] openURL: phoneNumberURL];  
}

@end