AMPIY Crypto App
A Flutter application for tracking cryptocurrency prices, with features like market variation graphs, hot coins, and top gainers. This app uses WebSocket to receive real-time updates and provides a rich user interface with various sections.

Features
Real-time cryptocurrency price updates via WebSocket
Market variation spectrum graph
Hot coins and top gainers sections
Interactive UI with action buttons and crypto information
Table of Contents
Prerequisites
Setup and Installation
Running the App
Project Structure
Contributing
License
Prerequisites
Before you begin, ensure you have the following installed:

Flutter (latest stable version)
Dart (comes with Flutter)
Firebase (for authentication and Firestore, if used)
Setup and Installation
Clone the repository

sh
Copy code
git clone https://github.com/your-username/ampiy-crypto-app.git
cd ampiy-crypto-app
Install dependencies

Run the following command to fetch all the dependencies:

sh
Copy code
flutter pub get
Configure Firebase

Follow the instructions on Firebase Setup for Flutter to set up Firebase for your project. Add your google-services.json (for Android) or GoogleService-Info.plist (for iOS) to the respective directories.

WebSocket Endpoint

Ensure that the WebSocket endpoint (ws://prereg.ex.api.ampiy.com/prices) is active and accessible. You may need to replace this with your WebSocket server URL if different.

Running the App
Run the app

Use the following command to run the app on your connected device or emulator:

sh
Copy code
flutter run
Build the app

To build the app for release, use:

sh
Copy code
flutter build apk --release
or for iOS:

sh
Copy code
flutter build ios --release
Project Structure
Here's an overview of the project's structure:

lib/
models/
crypto_model.dart - Defines the Crypto model class.
widgets/
coin_list.dart - Displays a list of cryptocurrencies.
hot_coins_section.dart - Displays the top hot coins in a grid.
market_variation_graph.dart - Displays market variation data in a graph.
section_card.dart - A reusable card widget for sections.
top_gainers_section.dart - Displays top gainers.
pages/
crypto_page.dart - Main page displaying the app content.
main.dart - Entry point of the app.
Contributing
Contributions are welcome! If you have suggestions or improvements, please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Make your changes.
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new Pull Request.
