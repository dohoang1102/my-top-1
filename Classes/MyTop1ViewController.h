#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MyTop1ViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
  IBOutlet UILabel *instructionsLabel;
  IBOutlet UIButton *setFavoritePersonButton;
}

@property(nonatomic, retain) UILabel *instructionsLabel;
@property(nonatomic, retain) UIButton *setFavoritePersonButton;

- (IBAction)showAddressBookContacts:(id)sender;

@end