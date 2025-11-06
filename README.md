# Sandwich Shop App

A Flutter application designed for a sandwich shop to manage orders, customize sandwiches, and track quantities. The app provides a user-friendly interface for selecting sandwich types, bread options, and adding notes for customization.

---

## Key Features
- **Order Management**: Add or remove sandwiches from the order.
- **Customization**: Choose between different bread types (e.g., white, wheat, wholemeal) and sandwich sizes (e.g., footlong, six-inch).
- **Notes**: Add special instructions for each order (e.g., "no onions", "extra pickles").
- **Responsive Design**: Works seamlessly on different screen sizes.
- **Testing**: Includes widget tests to ensure app reliability.

---

## Installation and Setup Instructions

### Prerequisites
- **Operating System**: Windows, macOS, or Linux
- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Included with Flutter
- **Tools**: Git, IDE (e.g., Visual Studio Code, Android Studio)

### Steps to Install
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/sandwich_shop.git
   cd sandwich_shop

    Install Dependencies: Run the following command to fetch all required packages:
        --flutter pub get

    Run the App: To launch the app on an emulator or connected device:
        --flutter run
    
    Run Tests: To execute the widget tests:
        flutter test


Usage Instructions
    Main Features
        Add Sandwiches:
            Tap the "Add" button to increase the quantity of sandwiches in the order.
        Remove Sandwiches:
            Tap the "Remove" button to decrease the quantity.
        Customize Orders:
            Select the sandwich size (footlong or six-inch).
            Choose the bread type from the dropdown menu.
            Add special instructions in the notes field.
        View Order Summary:
            The app displays the current order details, including quantity, sandwich type, bread type, and notes.

Project Structure and Technologies Used:
    Folder Structure:
        sandwich_shop/
        ├── lib/
        │   ├── main.dart                # Entry point of the app
        │   ├── views/
        │   │   ├── app_styles.dart      # Styling and theme configurations
        │   │   └── order_screen.dart    # Main UI for managing orders
        │   ├── repositories/
        │       └── order_repository.dart # Business logic for managing orders
        ├── test/
        │   ├── views/
        │       └── widget_test.dart     # Widget tests for the app
        ├── [pubspec.yaml](http://_vscodecontentref_/1)                 # Project dependencies and metadata

    Key Technologies
        Flutter: Framework for building the app.
        Dart: Programming language used for Flutter development.
        Widget Tests: Ensures app reliability and correctness.
    Key Dependencies
        flutter: Core Flutter SDK.
        cupertino_icons: iOS-style icons.
        flutter_test: Testing utilities for Flutter.

Known Issues or Limitations:
    No Backend Integration: The app does not save orders persistently.
    Limited Customization: Only basic sandwich options are available.

Future Improvements:
    Add backend support for saving and retrieving orders.
    Enhance the UI with animations and additional customization options.

Contribution Guidelines:
    Fork the repository.
    Create a new branch for your feature or bug fix.
    Submit a pull request with a detailed description of your changes.

Contact Information
    Developer: Konstantinos Savva
    Email: kon.savva05@gmail.com
    GitHub: kotsiossav
    

