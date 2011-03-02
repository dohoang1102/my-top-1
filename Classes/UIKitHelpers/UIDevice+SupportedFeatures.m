#import "UIDevice+SupportedFeatures.h"
#import <Foundation/Foundation.h>

@implementation UIDevice (SupportedFeatures)

+ (BOOL)canPerformPhoneCalls
{
  NSURL *phoneNumberURL = [NSURL URLWithString: @"tel://"];                           
  
  return [[UIApplication sharedApplication] canOpenURL: phoneNumberURL];
}

@end