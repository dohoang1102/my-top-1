#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Call : NSObject
{
}

+ (BOOL)toNumber:(NSString*)phoneNumber;
+ (BOOL)toNumber:(NSString*)phoneNumber withErrorMessage:(NSString*)errorMessage;
+ (BOOL)toNumber:(NSString*)phoneNumber withErrorTitle:(NSString*)errorTitle;	 	
+ (BOOL)toNumber:(NSString*)phoneNumber withErrorMessage:(NSString*)errorMessage andErrorTitle:(NSString*)errorTitle;

@end