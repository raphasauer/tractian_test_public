# Tractian Test Project

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Setup Instructions](#setup-instructions)
5. [Running the Application](#running-the-application)
6. [Technical Considerations](#technical-considerations)
7. [Contact Info](#contact-info)


## Introduction

This project is a technical test for a job application at Tractian. The application showcases the ability to handle a treeview component for unit selection and details, demonstrating knowledge in Flutter, GetX state management, and MVVM architecture.

## Features

- Unit selection page with a list of available units
- Detailed view of the selected unit's hierarchy
- Expandable and collapsible treeview component
- Filtering assets by their status, type and name
- State management using GetX
- Mock data to simulate real-world data
- Unit tests for ViewModels and utility functions

## Technologies Used

- [Flutter](https://flutter.dev/) - UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- [GetX](https://pub.dev/packages/get) - State management, dependency injection, and route management solution for Flutter.
- [Dart](https://dart.dev/get-dart) - Programming language optimized for building mobile, desktop, server, and web applications.

## Setup Instructions

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository:**

   ```bash
   git clone [https://github.com/your-username/tractian_test_project.git](https://github.com/your-username/tractian_test_project.git)
   cd tractian_test_project
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

### Running the Application

To run the application on your preferred device or emulator, use the following command:

1. **Running app**
    ```bash
    flutter run
    ```

## Technical Considerations

I've made the following technical considerations:

* Architecture: this follows the model, view, viewmodel (MVVM) architecture, as it is the one most closely resembling the one used at Tractian;
* State management: even though such simple app could be made only using `provider` or `setState` as its state manager, I've chosen GetX since it is the state management currently used in production by Tractian;
* Testing: unit tests for the viewmodels were implemented, as they are the building blocks of this application and ensuring that they work correctly is paramount. To run the tests:
```bash
    flutter test
```
* Environment used: the following environment was used in order to code this application:
```
Flutter 3.10.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision f468f3366c (12 months ago) • 2023-07-12 15:19:05 -0700
Engine • revision cdbeda788a
Tools • Dart 3.0.6 • DevTools 2.23.1
```

* Performance: in the current implementation, state data is saved directly to the user's device memory. This approach works due to the small data set used for this project. However, in a real-world scenario, it would be essential to implement a more efficient caching mechanism. This would involve storing the current state information in memory and, once the memory limit is reached, offloading additional states to a temporary file on the device's storage. This ensures optimal performance and efficient use of resources.

### Contact Info
You can reach out to me at the following email: raphasauer@gmail.com

