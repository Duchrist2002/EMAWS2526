# 💸 UniBudget

UniBudget is a beautiful, personal finance and budgeting application designed for students. It helps you track expenses, manage your monthly budget, and visualize your spending habits through clean, intuitive charts.

## 🚀 Features

- **Dashboard:** At-a-glance view of your budget, total spent, and remaining balance.
- **Expense Tracking:** Easily log expenses with categories and notes.
- **Budget Management:** Set and edit your monthly budget dynamically.
- **Interactive Statistics:** Visualize your spending with Bar Charts, Donut Charts, and Trend Lines.
- **History:** Keep track of all your past transactions.
- **Authentication:** Secure Firebase Authentication with a fallback "Demo Mode".
- **Dark Mode:** A gorgeous dark theme that is easy on the eyes.

## 📱 Download the APK (Android)

You can download the latest compiled version of the app directly from GitHub Actions!

1. Go to the **[Actions tab](https://github.com/Duchrist2002/EMAWS2526/actions)** on this repository.
2. Click on the latest successful workflow run for **"Build Android APK"**.
3. Scroll down to the **Artifacts** section.
4. Click on **`UniBudget-APK`** to download the file.
5. Transfer it to your Android device, open it, and install!

## 🛠️ Architecture

UniBudget is built using a clean architecture pattern:
- **State Management:** `flutter_bloc` (Cubit)
- **Data Persistence:** `shared_preferences`
- **Charts:** `fl_chart`
- **Auth:** `firebase_auth`

The UI is separated from the business logic, ensuring a scalable and maintainable codebase.

## 💻 Running Locally

To run the project on your own machine:

1. Ensure you have [Flutter installed](https://docs.flutter.dev/get-started/install).
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the app on your connected device or emulator.

> **Note on Firebase:** If you haven't configured Firebase locally, the app will automatically fall back to **Demo Mode**, allowing you to test the full UI without needing a backend connection.
