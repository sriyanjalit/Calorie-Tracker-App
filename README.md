# Calorie Tracker App

A cross-platform (Flutter) app to track your daily calorie intake, set goals, and view your meal history. Supports offline storage and a clean, modern UI.

## Features
- Add meals manually with calories and details
- Set and update your daily calorie goal
- View daily progress with a progress bar
- See meal history grouped by date
- Weekly calorie summary
- Offline support (local SQLite database)
- Simple, clean navigation

## Screenshots
*Add your screenshots here*

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code (with Flutter/Dart plugins)
- Android/iOS emulator or real device

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/calorie_tracker_app.git
   cd calorie_tracker_app
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the app:**
   ```sh
   flutter run
   ```
   - If you have multiple devices, specify one with `-d <device_id>`

### Troubleshooting
- **NDK/SDK issues:** Ensure the correct NDK version is installed and set in `android/app/build.gradle.kts`.
- **intl/date errors:** Make sure `intl` is in your `pubspec.yaml` and run `flutter pub get`.
- **Developer Mode:** On Windows, enable Developer Mode for symlink support.

## Project Structure
```
lib/
  main.dart
  models/
  providers/
  screens/
  services/
```

## Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

## License
[MIT](LICENSE)

---

*Built with Flutter ❤️*

---

## What the Warnings Mean

```
warning: in the working copy of 'file', LF will be replaced by CRLF the next time Git touches it
```

- **LF** = Line Feed (Unix/Linux/Mac line ending)
- **CRLF** = Carriage Return + Line Feed (Windows line ending)
- Git is warning you that when you check out or commit files, it may convert line endings from LF to CRLF (or vice versa) depending on your system and Git settings.

---

## Should You Worry?

**No!**  
- This is normal when working on Windows with projects that may have been created on Linux/Mac or by Flutter tools.
- It does **not** affect your code or your ability to push to GitHub or collaborate with others.

---

## How to Avoid or Silence These Warnings (Optional)

If you want to avoid these warnings, you can set a `.gitattributes` file in your repo root with:

```
<code_block_to_apply_changes_from>
```

Or, you can configure Git globally to handle line endings:

- For Windows (recommended):
  ```sh
  git config --global core.autocrlf true
  ```

---

## What to Do Next

- You can safely continue with:
  ```sh
  git commit -m "Initial commit"
  git remote add origin <your-github-repo-url>
  git push -u origin main
  ```
- The warnings will not prevent you from using git or uploading your project.

---

**Summary:**  
These are just line ending warnings. Your project and git repo are fine!
