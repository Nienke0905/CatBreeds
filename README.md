# CatBreeds

For this assessment, I utilized TheCatAPI to retrieve a compilation of cat breeds and display one image for each breed. From the outset, I prioritized functionality and user experience over design aesthetics. I decided to go for the MVVM architecture, as it was mentioned in the introduction chat, that this is used by Egeniq. The choice for SwiftUI over UIKit was made, as prototyping with SwiftUI is quicker with less boilerplate code. 

One of the challenges I encountered was implementing image caching, which demanded a considerable amount of time. Nevertheless, I recognized its importance in enhancing user experience and therefore decided to incorporate it.

Due to the time constraint, there are several areas that require significant improvement:
- Test coverage: To ensure the app's stability and reliability, it is crucial to increase test coverage by implementing comprehensive unit and integration tests, especially of the ViewModels.
- Abstraction: The CatBreedsListViewModel handles networking directly instead of having an API client.
- Flow of data: The flow is not making use of the full extent of reactive programming. It only exists between view and view model, but not towards the networking, image and favorites manager
- Accessibility features: It is essential to incorporate support for accessibility features such as voice-over labels and adjustable font sizes. This will ensure a more inclusive and user-friendly experience for all users.
- Overall UI: The user interface could benefit from refinement to enhance its visual appeal and usability. Improving the layout, color scheme, and interaction design will contribute to a more polished application.
- Improved error handling: Enhancing the error handling mechanism will prevent unexpected crashes and provide users with clear and helpful error messages when something goes wrong.
- Implementing pagination: Pagination will ensure a smoother user experience, especially when dealing with a large dataset.
- Supporting landscape mode: Adapting the app to function seamlessly in both portrait and landscape orientations will provide users with more flexibility in how they interact with the content.
- Localization: Making the app available in multiple languages will broaden its reach and cater to a more diverse audience.
- Reusable variables for common layout properties: For maintainability and consistency of the app's layout, I intend to incorporate the use of reusable variables for common layout properties, such as padding constants. By defining these variables, we can ensure uniform spacing throughout the app and make it easier to update and modify the layout in the future.
- Implementing a launch screen: Introducing a well-designed launch screen will improve the app's professionalism and create a more seamless transition when users open the application.
- App icon: Creating an app icon that aligns with the app's theme and purpose is essential for a more polished and professional presentation.

