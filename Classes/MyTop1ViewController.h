#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MyTop1ViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
}

- (IBAction)showAddressBookContacts:(id)sender;

@end