#import "MyTop1ViewController.h"

@implementation MyTop1ViewController

#pragma mark -
#pragma mark IBActions

- (IBAction)showAddressBookContacts:(id)sender
{
  ABPeoplePickerNavigationController *peoplePickerNavigationController = [[ABPeoplePickerNavigationController alloc] init];
  
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
  [self dismissModalViewControllerAnimated: YES];
  
	return YES;
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