#import "MyTop1ViewController.h"
#import <AddressBook/AddressBook.h>

@implementation MyTop1ViewController

@synthesize instructionsLabel, setFavoritePersonButton;

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

- (void)setInstructionsWithPersonName:(NSString *)personName using:(NSString *)phoneLabel withNumber:(NSString *)phoneNumber
{
  self.instructionsLabel.text = 
    [NSString stringWithFormat: @"You chose %@ (%@: %@) as your favorite person. Next time you open My Top 1 you'll call him/her automatically.", 
   personName, phoneLabel, phoneNumber];
  
  [self.setFavoritePersonButton setTitle: @"Change your favorite person" forState: UIControlStateNormal];
}

- (void)saveOnUserDefaults:(NSString *)favoriteNumber forPerson:(NSString *)person using:(NSString *)phoneLabel;
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject: person forKey: @"FavoritePersonName"];  
  [defaults setObject: phoneLabel forKey: @"FavoriteNumberLabel"];  
  [defaults setObject: favoriteNumber forKey: @"FavoriteNumberWithFullFormat"];  
}

- (void)saveFavoriteNumber:(NSString *)favoriteNumber
{
  NSCharacterSet *phoneNumberCharacters = [NSCharacterSet characterSetWithCharactersInString: @"+*0123456789"];
  
  NSArray *components = [favoriteNumber componentsSeparatedByCharactersInSet: [phoneNumberCharacters invertedSet]];
  
  favoriteNumber = [components componentsJoinedByString: @""];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject: favoriteNumber forKey: @"FavoriteNumber"];  
  
  [defaults synchronize];
}

- (void)setFavoritePerson:(ABRecordRef)person using:(NSString *)phoneLabel withNumber:(NSString *)phoneNumber;
{
  [self setInstructionsWithPersonName: [self fullNameFor: person] using: phoneLabel withNumber: phoneNumber];
  
  [self saveOnUserDefaults: phoneNumber forPerson: [self fullNameFor: person] using: phoneLabel];
  
  [self saveFavoriteNumber: phoneNumber];
  
  [self dismissModalViewControllerAnimated: YES];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
 
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  if([defaults stringForKey: @"FavoriteNumber"])
    [self setInstructionsWithPersonName: [defaults stringForKey: @"FavoritePersonName"]
                                  using: [defaults stringForKey: @"FavoriteNumberLabel"]
                             withNumber: [defaults stringForKey: @"FavoriteNumberWithFullFormat"]];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)showAddressBookContacts:(id)sender
{
  ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
  
  NSArray *phoneNumber = [NSArray arrayWithObject: [NSNumber numberWithInt: kABPersonPhoneProperty]];
	
	peoplePicker.displayedProperties = phoneNumber;
  
  peoplePicker.peoplePickerDelegate = self;
  
  [self presentModalViewController: peoplePicker animated: YES];
  
  [peoplePicker release];   
}

#pragma mark -
#pragma mark ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
  CFTypeRef phonePropertyReference = ABRecordCopyValue(person, kABPersonPhoneProperty);
  
  NSArray *phoneNumbers = (NSArray *)ABMultiValueCopyArrayOfAllValues(phonePropertyReference);

  if([phoneNumbers count] == 1)
  {
    CFStringRef phoneLabelReference = ABMultiValueCopyLabelAtIndex(phonePropertyReference, 0);
    NSString *phoneLabel = (NSString *)ABAddressBookCopyLocalizedLabel(phoneLabelReference);
    
    NSString *phoneNumber = [phoneNumbers objectAtIndex: 0];
    
    [self setFavoritePerson: person using: phoneLabel withNumber: phoneNumber];
    
    return NO;
  }
  else
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier
{
  if(property == kABPersonPhoneProperty)
  {
    CFTypeRef phonePropertyReference = ABRecordCopyValue(person, property);
    
    CFIndex phonePropertyValueIndex = ABMultiValueGetIndexForIdentifier(phonePropertyReference, identifier);
    
    CFStringRef phoneLabelReference = ABMultiValueCopyLabelAtIndex(phonePropertyReference, phonePropertyValueIndex);
    NSString *phoneLabel = (NSString *)ABAddressBookCopyLocalizedLabel(phoneLabelReference);
    
    NSString *phoneNumber = (NSString *)ABMultiValueCopyValueAtIndex(phonePropertyReference, phonePropertyValueIndex);
    
    [self setFavoritePerson: person using: phoneLabel withNumber: phoneNumber];
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
  [super didReceiveMemoryWarning];
}

- (void)dealloc 
{
  [self.instructionsLabel release];
  [self.setFavoritePersonButton release];
  
  [super dealloc];
}

@end