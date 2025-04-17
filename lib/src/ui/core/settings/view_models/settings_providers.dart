// We don't have an actual instance of SharedPreferences, and we can't get one except asynchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final countProvider = NotifierProvider<CountNotifier, int>(CountNotifier.new);

class CountNotifier extends Notifier<int> {
  @override
  int build() {
    // We'd like to obtain an instance of shared preferences synchronously in a provider
    final preferences = ref.watch(sharedPreferencesProvider);

    // Load the initial counter value from persistent storage on start,
    // or fallback to 0 if it doesn't exist.
    final currentValue = preferences.getInt('count') ?? 0;

    // on change save the value
    listenSelf((prev, next) {
      preferences.setInt('count', next);
    });
    return currentValue;
  }

  // After a click, increment the counter state
  void increment() => state++;
}

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final themeMode =
        preferences.getString('themeMode') ?? ThemeMode.system.name;
    listenSelf((prev, next) {
      preferences.setString('themeMode', next.name);
    });
    return ThemeMode.values.byName(themeMode);
  }

  void changeTheme(ThemeMode themeMode) => state = themeMode;
}
