#import "MyTop1ViewController.h"
#import <AddressBook/AddressBook.h>

@implementation MyTop1ViewController

#pragma mark -
#pragma mark IBActions

- (IBAction)showAddressBookContacts:(id)sender
{
  ABPeoplePickerNavigationController *peoplePickerNavigationController = [[ABPeoplePickerNavigationController alloc] init];
  
  NSArray *phoneNumber = [NSArray arrayWithObject: [NSNumber numberWithInt: kABPersonPhoneProperty]];
	
	//peoplePickerNavigationController.displayedProperties = phoneNumber;
  
  peoplePickerNavigationController.peoplePickerDelegate = self;
  
  [self presentModalViewController: peoplePickerNavigationController animated:YES];
  
  [peoplePickerNavigationController release];   
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
  return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
  if(property == kABPersonPhoneProperty)
  {
    NSString *firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *fullName; 
    
    if(lastName)
      fullName = [firstName stringByAppendingFormat: @" %@", lastName];
    else
      fullName = firstName;
    
    CFTypeRef propertyReference = ABRecordCopyValue(person, property);
    
    CFIndex propertyValueIndex = ABMultiValueGetIndexForIdentifier(propertyReference, identifier);
    
    CFTypeRef selectedPhoneNumberLabel = (NSString *)ABMultiValueCopyLabelAtIndex(propertyReference, propertyValueIndex);
    CFTypeRef selectedPhoneNumberValue = (NSString *)ABMultiValueCopyValueAtIndex(propertyReference, propertyValueIndex);
    
    NSLog(@"You chose %@ (%@: %@) as your favorite contact. Next time you open My Top 1 you'll call him/her automatically.", 
          fullName, selectedPhoneNumberLabel, selectedPhoneNumberValue);
    
    [self dismissModalViewControllerAnimated: YES];
  }
  
	return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
  [self dismissModalViewControllerAnimated: YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
  {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
  [super dealloc];
}

@end