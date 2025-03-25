# HeroApp

A Swift and SwiftUI application that displays superhero information from the Superhero API. This project demonstrates the implementation of the MVVM (Model-View-ViewModel) architecture with a Router pattern.

## Features

- Browse a comprehensive list of superheroes
- Search heroes by name
- View detailed information about each hero:
  - Basic info (name, race, alignment)
  - Power statistics
  - Publisher and base of operations
  - Additional biography information

## Project Structure

The project follows a clean architecture pattern with proper separation of concerns:

```
HeroApp/
├── App/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Models/
│   ├── API/
│   │   ├── HeroEntity.swift
│   │   └── HeroDetailEntity.swift
│   └── UI/
│       ├── HeroListModel.swift
│       └── HeroDetailModel.swift
├── Views/
│   ├── HeroList/
│   │   └── HeroListView.swift
│   └── HeroDetail/
│       └── HeroDetailView.swift
├── ViewModels/
│   ├── HeroListViewModel.swift
│   └── HeroDetailViewModel.swift
├── Services/
│   └── HeroService.swift
└── Routing/
    └── HeroRouter.swift
```

## Architecture

### MVVM + Router Pattern

The app uses the MVVM architecture pattern with a Router component:

- **Models**: Data structures for API responses and UI representation
  - API Models: Decode data from the API
  - UI Models: Transform API data for use in the UI

- **Views**: SwiftUI views that present the UI
  - HeroListView: Displays a list of heroes with search functionality
  - HeroDetailView: Shows detailed information about a selected hero

- **ViewModels**: Handle business logic and data transformation
  - HeroListViewModel: Manages the hero list data and search functionality
  - HeroDetailViewModel: Manages the detailed hero information

- **Router**: Handles navigation between screens
  - HeroRouter: Manages transitions between different views

### Thread Safety and State Management

- MainActor isolation for UI updates
- Proper loading and error states
- Nonisolated initializers where appropriate

## Implementation Details

### API Integration

The app uses the Superhero API (akabab.github.io/superhero-api) and implements:
- `/all.json` endpoint to fetch all heroes
- `/id/{id}.json` endpoint to fetch specific hero details

### Networking

- URLSession for network requests
- Custom error handling
- Asynchronous operations with Swift Concurrency (async/await)

### UI Features

- Responsive layouts for various iPhone sizes
- Clean, minimalist design
- Loading indicators and error states
- Debounced search functionality

## Setup Instructions

1. Clone the repository:
```
git clone https://github.com/yourusername/HeroApp.git
```

2. Open the project in Xcode:
```
cd HeroApp
open HeroApp.xcodeproj
```

3. Build and run the application on a simulator or physical device.

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Architecture Decisions

### Why MVVM + Router?

- **Separation of Concerns**: Clean separation between UI, business logic, and navigation
- **Testability**: ViewModels are easy to test in isolation
- **Reusability**: Components can be reused across the app
- **Maintenance**: Easier to maintain and extend the codebase

### Why SwiftUI with UIKit Integration?

- **Modern UI Framework**: SwiftUI provides a declarative and concise way to build UIs
- **UIKit Integration**: Using UINavigationController for reliable navigation stack management
- **Best of Both Worlds**: Leveraging SwiftUI's simplicity with UIKit's maturity

### Why Swift Concurrency?

- **Code Readability**: Async/await pattern is more readable than completion handlers
- **Error Handling**: Simplified error handling with do-catch syntax
- **Thread Safety**: Better thread management with MainActor

### Memory Management

- Proper use of weak references to avoid retain cycles
- Controlled lifecycle of ViewModels and Views
- Clean teardown of resources

## Future Improvements

- Add favorites functionality
- Implement image caching
- Add pagination for large datasets
- Implement sorting and filtering options
- Add unit and UI tests
