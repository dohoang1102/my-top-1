#import "MyTop1ViewController.h"
#import <AddressBook/AddressBook.h>

@implementation MyTop1ViewController

#pragma mark -
#pragma mark IBActions

- (IBAction)showAddressBookContacts:(id)sender
{
  ABPeoplePickerNavigationController *peoplePickerNavigationController = [[ABPeoplePickerNavigationController alloc] init];
  
  NSArray *phoneNumber = [NSArray arrayWithObject: [NSNumber numberWithInt: kABPersonPhoneProperty]];
	
	peoplePickerNavigationController.displayedProperties = phoneNumber;
  
  peoplePickerNavigationController.peoplePickerDelegate = self;
  
  [self presentModalViewController: peoplePickerNavigationController animated: YES];
  
  [peoplePickerNavigationController release];   
}

#pragma mark -
#pragma mark "Protected" methods

- (NSString *)fullNameFor:(ABRecordRef)person
{
  NSString *firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
  NSString *lastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
  
  if(lastName)
    return [firstName stringByAppendingFormat: @" %@", lastName];
  else
    return firstName;
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
  CFTypeRef selectedPersonPhonePropertyReference = ABRecordCopyValue(person, kABPersonPhoneProperty);
  
  NSArray *selectedPersonPhoneNumbers = (NSArray *)ABMultiValueCopyArrayOfAllValues(selectedPersonPhonePropertyReference);
                            
  if([selectedPersonPhoneNumbers count] > 1)
    return YES;
  else
  {
    NSString *selectedPersonPhoneLabel = (NSString *)ABMultiValueCopyLabelAtIndex(selectedPersonPhonePropertyReference, 0);
    
    NSLog(@"You chose %@ (%@: %@) as your favorite contact. Next time you open My Top 1 you'll call him/her automatically.", 
      [self fullNameFor: person], selectedPersonPhoneLabel, [selectedPersonPhoneNumbers objectAtIndex: 0]);
    
    [self dismissModalViewControllerAnimated: YES];
    
    return NO;
  }
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
  if(property == kABPersonPhoneProperty)
  {
    CFTypeRef propertyReference = ABRecordCopyValue(person, property);
    
    CFIndex propertyValueIndex = ABMultiValueGetIndexForIdentifier(propertyReference, identifier);
    
    NSString *phoneNumberLabel = (NSString *)ABMultiValueCopyLabelAtIndex(propertyReference, propertyValueIndex);
    NSString *phoneNumberValue = (NSString *)ABMultiValueCopyValueAtIndex(propertyReference, propertyValueIndex);
    
    NSLog(@"You chose %@ (%@: %@) as your favorite contact. Next time you open My Top 1 you'll call him/her automatically.", 
          [self fullNameFor: person], phoneNumberLabel, phoneNumberValue);
    
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