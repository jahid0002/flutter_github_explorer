# Flutter GitHub Explorer

A Flutter application that searches GitHub for repositories using the keyword "Flutter" and displays the top 50 most popular repositories with offline support.

## Features

- 🔍 Search GitHub repositories with "Flutter" keyword
- ⭐ Display top 50 most starred repositories
- 📱 Offline support with local caching
- 🔄 Sort by stars or last updated date
- 💾 Persistent sort preference
- 📄 Detailed repository view with owner information
- 🌙 Light and Dark theme support
- 🔗 Deep linking to repository and owner profiles

## Architecture

This project follows **Clean Architecture** principles with three main layers:

### 1. Data Layer

- **Data Sources**: Remote (API) and Local (Hive database)
- **Models**: JSON serializable data models with Hive adapters
- **Repository Implementation**: Implements domain repository contracts

### 2. Domain Layer

- **Entities**: Pure Dart business objects
- **Repositories**: Abstract repository contracts
- **Use Cases**: Business logic implementation

### 3. Presentation Layer

- **Bloc**: State management using flutter_bloc
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## Tech Stack

### Core Technologies

- **Flutter SDK**: ^3.0.0
- **Dart**: ^3.0.0

### State Management

- **flutter_bloc**: ^8.1.3 - BLoC pattern implementation
- **equatable**: ^2.0.5 - Value equality

### Dependency Injection

- **get_it**: ^7.6.4 - Service locator

### Navigation

- **go_router**: ^12.1.1 - Declarative routing

### Local Storage

- **shared_preferences**: ^2.5.4 - Key-value storage for preferences
- **hive**: ^2.2.3 - Fast, lightweight NoSQL database
- **hive_flutter**: ^1.1.0 - Hive integration for Flutter

### Networking

- **http**: ^1.2.1 - HTTP client
- **connectivity_plus**: ^5.0.2 - Network connectivity check

### Functional Programming

- **dartz**: ^0.10.1 - Either type for error handling

### UI/UX

- **cached_network_image**: ^3.3.0 - Image caching
- **intl**: ^0.18.1 - Date formatting

### Code Generation

- **build_runner**: ^2.4.6 - Code generation tool
- **hive_generator**: ^2.0.1 - Generates Hive adapters
- **json_serializable**: ^6.7.1 - JSON serialization

## Project Structure

```text
lib/
├── core/
│   ├── error/              # Error handling
│   ├── network/            # Network utilities
│   ├── theme/              # App theming
│   ├── utils/              # Helper functions
│   └── usecases/           # Base use case
│
├── features/
│   └── github_repository/
│       ├── data/           # Data layer
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/         # Domain layer
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/   # Presentation layer
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
├── injection_container.dart  # Dependency injection setup
├── router.dart              # Navigation configuration
└── main.dart               # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository

```bash
git clone <repository-url>
cd flutter_github_explorer
```

2. Install dependencies

```bash
flutter pub get
```



3. Run the app

```bash
flutter run
```

## Usage

### Home Screen

- View list of top 50 Flutter repositories
- Pull to refresh data
- Sort repositories by:
  - ⭐ Stars (default)
  - 🔄 Last updated date
- Tap on any repository to view details

### Repository Details

- View repository name, description, and statistics
- See owner information with avatar
- View creation and last update dates
- Open repository in browser
- View owner profile

### Offline Mode

- Previously fetched data is cached locally
- Browse repositories without internet connection
- App shows cached data with offline indicator
- Automatic sync when connection is restored

## Configuration

### API Endpoint

Update the base URL in `lib/core/utils/constants.dart`:

```dart
static const String baseUrl = 'https://api.github.com';
```

### GitHub API Rate Limiting

The app uses unauthenticated GitHub API requests with a limit of 60 requests per hour. For higher limits, add a personal access token in the API headers.

## Building for Production

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Testing

Run tests with:

```bash
flutter test
```

Run tests with coverage:

```bash
flutter test --coverage
```

## Error Handling

The app implements comprehensive error handling:

- **ServerException**: API errors
- **CacheException**: Local storage errors
- **NetworkException**: No internet connection

All errors are converted to **Failures** in the domain layer:

- **ServerFailure**
- **CacheFailure**
- **NetworkFailure**

## State Management Flow

```text
User Action → Event → Bloc → UseCase → Repository → DataSource
                ↓
            State Update
                ↓
           UI Rebuild
```

## Key Features Implementation

### Offline Support

- Uses Hive for local NoSQL database
- Caches repositories after successful API fetch
- Displays cached data when offline
- Shows offline indicator to user

### Sorting Persistence

- Stores user's sort preference in Hive
- Restores preference on app restart
- Sort by stars or last updated date

### Error Recovery

- Network error: Shows cached data with warning
- No cached data: Shows error with retry button
- Auto-retry on connection restore

## Dependencies Explanation

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management with BLoC pattern |
| get_it | Dependency injection / Service locator |
| go_router | Declarative navigation |
| hive | Fast local NoSQL database |
| http | HTTP client for API calls |
| dartz | Functional programming (Either type) |
| connectivity_plus | Check network status |
| cached_network_image | Cache and display images |
| intl | Format dates and numbers |
| equatable | Value comparison for state |

## Code Generation

This project uses code generation for:

- Hive type adapters (`@HiveType`, `@HiveField`)
- JSON serialization (`@JsonSerializable`)

Run code generation:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch for changes:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Performance Optimizations

- Image caching with `cached_network_image`
- Lazy loading with `ListView.builder`
- Efficient state updates with BLoC
- Local caching to reduce API calls
- Optimized Hive database queries

## Future Enhancements

- [ ] Search functionality
- [ ] Favorite repositories
- [ ] Share repository links
- [ ] Multiple sort options
- [ ] Filter by language
- [ ] View commit history
- [ ] View contributors
- [ ] Pull request viewer
- [ ] Issue tracker
- [ ] Star/Unstar repositories

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Code Style

This project follows the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide. Please ensure your code adheres to these guidelines before submitting a PR.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- GitHub API for providing repository data
- Flutter community for amazing packages
- Clean Architecture principles by Robert C. Martin

## Contact

For questions or feedback, please open an issue on GitHub.

---

Made with ❤️ using Flutter