# Hotel Flutter App Case Study

## 1. Environment Setup

### Flutter Development and Testing Environment Setup

To set up the Flutter development and testing environment, the following steps were taken:

1. **Flutter SDK Installation**:  
    Download and install the Flutter SDK (version `3.29.0`) from the [Flutter website](https://flutter.dev/docs/get-started/install).

2. **Dart SDK**:  
    Dart is bundled with Flutter, and installation occurs automatically during the Flutter setup.

3. **IDE Installation**:  
    Install Android Studio and the Flutter & Dart plugins for it.

### Android Emulator Setup

Installed Android Studio and the Android SDK. Created and launched a Pixel 6 emulator with API 31 & 34:

```bash
flutter emulators --launch Pixel_6
```

4. **Patrol and integration_test Setup**:

#### Patrol

Added Patrol dependency in `pubspec.yaml`:

```yaml
dependencies:
  patrol: ^3.0.0
```

#### integration_test

Added the integration_test package in `pubspec.yaml`:

```yaml
dev_dependencies:
  integration_test:
     sdk: flutter
```

Imported integration_test in the test files:

```dart
import 'package:flutter_test/flutter_test.dart';
```

### Running Tests on Multiple Devices Simultaneously

To run tests on multiple devices (iOS and Android), the following commands were used:

```bash
flutter test integration_test -d emulator-5554
flutter test integration_test -d emulator-5558
```

## 2. Test Implementation

### Core Test Scenarios / Testing Strategy

1. **Widget Tests**:
    - Home Page Widget: Verify the presence of all key elements like tabs.
    - Hotel Page Widget: Verify the visibility of the search icon and presence of tabs.

2. **E2E Tests Using integration_test**:
    - Search Mechanism:
      - Verify that the search mechanism returns correct results.
      - Verify that clearing the search returns no results.

### Test Suite Implementation

#### Directory Structure

```plaintext
integration_test/
├── pages/
│   ├── home_page.dart
│   └── search_page.dart
├── tests/
│   ├── hotel_search_test.dart (E2E testing)
│   └── home_test.dart (Widget testing)
└── test_utils/
     └── reusableActions.dart (Reusable actions like tap and waits)
```

### Page Object Model Structure

1. **Pages**:
    - `home_page.dart`: Contains the home page actions and selectors.
    - `search_page.dart`: Contains the search page actions and selectors.

2. **Tests**:
    - `hotel_search_test.dart`: E2E test file to verify the search functionality.
    - `home_test.dart`: Widget test file to verify the UI components on the home page.

3. **Test Utils**:
    - `reusableActions.dart`: Contains reusable actions like clicking and waiting for elements.
## 3. Local Test Reporting

To generate a test report locally, you can use the following command:

```bash
flutter test integration_test > test_report.txt
```

This command will run the integration tests and save the test results in a `test_report.txt` file.

### Documentation of Test Structure

#### Test Organization

- `integration_test/pages/`: Contains page objects like `home_page.dart` and `search_page.dart` for UI elements and actions.
- `integration_test/tests/`: Contains tests such as `hotel_search_test.dart` (E2E tests) and `home_test.dart` (Widget tests).
- `integration_test/test_utils/`: Contains reusable actions like clicks and waits in `reusableActions.dart`.

#### Running Tests

To run tests, use the following command:

```bash
flutter test integration_test
```

This command will execute the integration tests for your Flutter application.




# Continuous Integration (CI) Setup for Flutter Android Tests

## Overview

This CI pipeline is set up to execute Android integration tests using GitHub Actions. It runs tests on two different Android emulators (API levels 31 and 34) and performs the following tasks:

1. **CI Configuration**: Automates the test execution process in a GitHub Actions workflow.
2. **Parallel Testing**: Runs the tests on multiple Android emulators with different API levels.
3. **Test Reporting**: Collects and uploads test results.
4. **Test Artifacts**: Handles the test artifacts, including the emulator logs and test result files.

## 1. GitHub Actions Workflow Configuration

### File: `.github/workflows/android_parallel_tests.yml`

#### Key CI Configuration Details

**Steps Overview**:

- **Enable KVM for Emulator Acceleration**:  
  This step ensures the emulator runs smoothly and efficiently using KVM (Kernel-based Virtual Machine) for hardware acceleration.

- **Set Up Java**:  
  Java 17 is set up using the `actions/setup-java` GitHub Action. This is required for the Android build tools and Flutter integration.

- **Checkout the Code**:  
  This step checks out the repository code to the runner to begin the test execution process.

- **Set Up Android SDK**:  
  This action installs the necessary Android SDK components for building and running Android tests, including accepting the SDK licenses automatically.

- **Set Up Flutter**:  
  The Flutter setup is done using `subosito/flutter-action` which ensures Flutter dependencies are cached and the correct Flutter version is used for the tests.

- **Install Flutter Dependencies**:  
  The `flutter pub get` command installs any dependencies required for the project.

- **Install Android SDK Components**:  
  This step installs the required Android SDK components like platform tools, emulators, and build tools for the specific API levels defined in the matrix.

- **Run Android Emulator and Tests**:  
  The `android-emulator-runner` action sets up and runs the Android emulators with the specified API levels. It waits for the emulator to fully boot before running the Flutter integration tests. The integration tests are run using `flutter test` with the results saved in a `test-results.json` file.

- **Upload Test Artifacts**:  
  This step uploads test artifacts, including test result files (`test-results.json`) and emulator logs, so that the results can be analyzed later.

## 2. CI Reporting and Test Artifacts

**Test Reports**:

- The tests run on two different API levels (31 and 34), and the results are stored in `test-results.json` files.
- The results are uploaded as artifacts after the tests are executed, allowing easy access to them for later analysis.

**Example Test Artifacts**:

- **Test Results**:  
  The test results are saved in the `test-results.json` file and can be accessed through the "Artifacts" section in the GitHub Actions UI.

- **Emulator Logs**:  
  Emulator logs (`emulator.log`) are also uploaded as part of the artifacts for debugging purposes.

