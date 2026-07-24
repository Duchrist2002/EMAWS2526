# UniBudget

Student budget tracker built with Flutter (EMA WS25/26).

Features:
- Firebase Authentication (email + password)
- Local demo mode fallback
- Dashboard with monthly summary, quick tools, and recent transactions
- Dark mode toggle

See [ROADMAP.md](ROADMAP.md) for future developments.

## How to run

```bash
flutter pub get
flutter run
flutter run -d chrome
```

## Demo mode
If Firebase is not configured, the app runs with an in-memory demo account:
- email: student@uni.de
- password: 123456

You can also create a new account from the Sign-Up screen. State resets on reload.

## Firebase setup

1. Create a project at the Firebase console and enable Email/Password authentication.
2. Install the CLI and generate config:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This overwrites `lib/firebase_options.dart` with your project configuration. The app will then use real authentication instead of demo mode.

## Project structure

- lib/core/: theme and controllers
- lib/models/: data models
- lib/services/: authentication services
- lib/screens/: ui views (login, signup, dashboard)
- lib/widgets/: reusable ui components
- lib/main.dart: entry point
