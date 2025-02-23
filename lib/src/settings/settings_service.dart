import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
class SettingsService {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    String aString =
        await SharedPreferencesAsync().getString(SettingsKeys.themeMode.name) ??
            ThemeMode.system.name;
    return ThemeMode.values.byName(aString);
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally
    await prefs.setString(SettingsKeys.themeMode.name, theme.name);
  }
}

enum SettingsKeys {
  themeMode,
}
