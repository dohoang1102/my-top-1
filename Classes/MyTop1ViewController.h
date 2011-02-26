#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MyTop1ViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
  IBOutlet UILabel *instructionsLabel;
}

@property(nonatomic, retain) UILabel *instructionsLabel;

- (IBAction)showAddressBookContacts:(id)sender;

@end