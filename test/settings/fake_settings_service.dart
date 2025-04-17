// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FakeSettingService implements SettingsService {
//   ThemeMode _themeMode = ThemeMode.system;

//   @override
//   SharedPreferencesAsync get prefs => SharedPreferencesAsync();

//   // Loads the User's preferred ThemeMode from local or remote storage.
//   @override
//   Future<ThemeMode> themeMode() async => _themeMode;

//   // Persists the user's preferred ThemeMode to local or remote storage.
//   @override
//   Future<void> updateThemeMode(ThemeMode theme) async {
//     // Use the shared_preferences package to persist settings locally or the
//     // http package to persist settings over the network.
//     _themeMode = theme;
//   }
// }
