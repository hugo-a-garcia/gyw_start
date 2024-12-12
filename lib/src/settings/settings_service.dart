import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    return ThemeMode.values.byName(
        await SharedPreferencesAsync().getString(SettingsKeys.themeMode.name) ??
            ThemeMode.system.name);
    // return Future.value(
    //   ThemeMode.values.elementAt(
    //       await SharedPreferencesAsync().getInt(SettingsKeys.themeMode.name) ??
    //           0),
    // );
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    await prefs.setInt(SettingsKeys.themeMode.name, theme.index);
  }
}

enum SettingsKeys {
  themeMode,
}
