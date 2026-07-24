# UniBudget

A student budget-tracker built with Flutter (EMA WS25/26).

- **Auth**: Firebase Authentication (email + password), with a local **demo mode**
  fallback so the app runs before you connect a Firebase project.
- **Dashboard**: monthly summary, quick tools, and a recent-transactions list.
- **Dark mode**: toggle in the dashboard header.

See [ROADMAP.md](ROADMAP.md) for the plan toward a complete app.

## Run it

```bash
flutter pub get
flutter run            # mobile / desktop
flutter run -d chrome  # web
```

### Demo mode (no setup)
If Firebase isn't configured yet, the app runs against an in-memory demo account
so you can try the full flow immediately:

```
email:    student@uni.de
password: 123456
```

You can also create a new account from the Sign-Up screen (state resets on reload).

## Connect Firebase (enable real auth)

1. Create a project at the [Firebase console](https://console.firebase.google.com/)
   and enable **Authentication → Email/Password**.
2. Install the CLI and generate config:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   This overwrites `lib/firebase_options.dart` with your project's real values.
   Once the placeholders are gone, the app initializes Firebase automatically and
   uses real authentication instead of demo mode.

## Project structure

```
lib/
  core/          theme.dart, theme_controller.dart
  models/        transaction_model.dart
  services/      auth_service.dart        (Firebase + demo implementations)
  screens/       login, signup, page_home (dashboard)
  widgets/       custom_input_field, dashboard/ (budget card, transaction item)
  main.dart      Firebase init + AuthGate + theming
  firebase_options.dart   (placeholder until you run flutterfire configure)
```
