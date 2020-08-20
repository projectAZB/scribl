# scribl

## Architecture ##

The architecture of my application makes use of MVVM as much as possible, allowing the view controllers to act as the view layer concerned only with the display of the data the view models manage. My approach was that each ViewController instance was associated with a respective ViewModel instance that would encapsulate the functionality needed to display data/functionality to the user. Any shared functionality can go in the base classes, and through associated types I am able to simulate abstract class behavior as much as possible through the ViewModelBindable protocol to require a BaseViewController subclass to have a View Model attribute. I was able to attain a pretty clean separation of concerns through this, although in the interest of time I didn't follow the same approach with SignInViewController and used the UserManager directly instead of accessing it via a ViewModel which would be the cleanest/most consistent architecturally speaking.

## Reasoning Behing Technical Choices ##

I'll start off with the data persistence. First, I had opted to use CoreData to store the data locally, but then after some research found that Firestore has an exceptionally efficient offline data persistence, so I decided to kill two birds with one stone and use Firestore for my offline and remote data persistence layer so that I could focus on refining other functionality. 

In that same vein, to integrate Firestore, I chose to add the SDK manually as I tend to avoid CocoaPods since it's rather invasive (and since there isn't Firebase support for Carthage, my typical dependency manager choice)

For the main functionality of the project, the storing of drawings, I opted for storing each Stroke using ratios of the points to their respective coordinate systems. This allows me to store absolute ratios in Firebase so that no matter the screen size or orientation the points can be translated to whatever size frame is provided. I didn't try this out on iPad, but I'm sure this approach could be optimized much better, and take in scale, because I imagine on larger screens the drawings will be slightly distorted, as will the 'play' animation since the stroke distances will be different once normalized so the animations will not be exactly consistent across devices.

For the UI of the app, I opted to do it programmatically as that is always my first choice since it allows for customization (i.e. can apply styles across view controllers more easily/cleanly) and collaboration (i.e. avoiding storyboard merge conflicts)

## How I Would Do Things Differently ## 

Although I was able to complete all of the functionality, I would certainly refine it much more if I had more time/had to release it to production.

The UI could be much better, especially in the Gallery CollectionView with the display of contextual information on the GalleryCell. Also, instead of allowing users to provide usernames I just took the handle of their email, which isn't ideal. 

There needs to be more feedback for document adding and deleting errors, or Firestore loading errors in general. I only had time to put error handling into the Sign-In since it seemed it was the most vital there. 

I would add spinning loaders wherever appropriate for a better UX. 

I would add a sign-out button so that users can sign-out someway other than deleting the app. This is definitely not ideal, just was pressed for time and wasn't able to fit it in. Also Firebase auth session handling could be cleaner and more synchronized once an ability to sign out is added. 

I would add pull to load to the gallery so the user can pull data theirself. 

When a user clicks on their drawing from the Gallery, they can only delete their own drawing, not edit it. If I were to have more time I'd allow them to edit the drawings as well.
