// We don't have an actual instance of SharedPreferences, and we can't get one except asynchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

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

  void updateTheme(ThemeMode themeMode) => state = themeMode;
}

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class DefaultDeviceNotifier extends Notifier<String> {
  @override
  String build() {
    final preferences = ref.watch(sharedPreferencesProvider);
    final defaultDevice = preferences.getString('defaulltDevice') ?? '';
    listenSelf((prev, next) {
      preferences.setString('defaultDevice', next);
    });
    return defaultDevice;
  }
}

final defaultDeviceProvider =
    NotifierProvider<DefaultDeviceNotifier, String>(DefaultDeviceNotifier.new);
