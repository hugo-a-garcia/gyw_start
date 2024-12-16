import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gyw_start/src/settings/settings_service.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';
import 'package:shared_preferences/src/shared_preferences_async.dart';

void main() {
  const String stringKey = 'testString';
  const String testString = 'hello world';

  group('Shared preferences should', () {
    (SharedPreferencesAsync, FakeSharedPreferencesAsync) getPreferences() {
      final FakeSharedPreferencesAsync store = FakeSharedPreferencesAsync();
      SharedPreferencesAsyncPlatform.instance = store;
      final SharedPreferencesAsync preferences = SharedPreferencesAsync();
      return (preferences, store);
    }

    test('set and get theme_mode value using shared_preferences', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store,
      ) = getPreferences();
      expect(await preferences.getString(SettingsKeys.themeMode.name), null);
      await preferences.setString(
          SettingsKeys.themeMode.name, ThemeMode.dark.name);
      await preferences.setString(
          SettingsKeys.themeMode.name, ThemeMode.dark.name);
      expect(await preferences.getString(SettingsKeys.themeMode.name),
          ThemeMode.dark.name);
    });

    test('set and get theme_mode using settings_service', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store,
      ) = getPreferences();
      SettingsService service = SettingsService();
      expect(await preferences.getString(SettingsKeys.themeMode.name), null);
      expect(await service.themeMode(), ThemeMode.system);
      service.updateThemeMode(ThemeMode.dark);
      expect(await preferences.getString(SettingsKeys.themeMode.name),
          ThemeMode.dark.name);
      expect(await service.themeMode(), ThemeMode.dark);
    });
  });

  group('Async', () {
    (SharedPreferencesAsync, FakeSharedPreferencesAsync) getPreferences() {
      final FakeSharedPreferencesAsync store = FakeSharedPreferencesAsync();
      SharedPreferencesAsyncPlatform.instance = store;
      final SharedPreferencesAsync preferences = SharedPreferencesAsync();
      return (preferences, store);
    }

    test('set and get String', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store,
      ) = getPreferences();
      await preferences.setString(stringKey, testString);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('setString', arguments: <dynamic>[
            stringKey,
            testString,
          ]),
        ],
      );
      store.log.clear();
      expect(await preferences.getString(stringKey), testString);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('getString', arguments: <dynamic>[
            stringKey,
          ]),
        ],
      );
    });
  });
}

base class FakeSharedPreferencesAsync extends SharedPreferencesAsyncPlatform {
  final InMemorySharedPreferencesAsync backend =
      InMemorySharedPreferencesAsync.empty();
  final List<MethodCall> log = <MethodCall>[];

  @override
  Future<bool> clear(
      ClearPreferencesParameters parameters, SharedPreferencesOptions options) {
    log.add(MethodCall('clear', <Object>[...?parameters.filter.allowList]));
    return backend.clear(parameters, options);
  }

  @override
  Future<bool?> getBool(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getBool', <String>[key]));
    return backend.getBool(key, options);
  }

  @override
  Future<double?> getDouble(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getDouble', <String>[key]));
    return backend.getDouble(key, options);
  }

  @override
  Future<int?> getInt(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getInt', <String>[key]));
    return backend.getInt(key, options);
  }

  @override
  Future<Set<String>> getKeys(
      GetPreferencesParameters parameters, SharedPreferencesOptions options) {
    log.add(MethodCall('getKeys', <String>[...?parameters.filter.allowList]));
    return backend.getKeys(parameters, options);
  }

  @override
  Future<Map<String, Object>> getPreferences(
      GetPreferencesParameters parameters, SharedPreferencesOptions options) {
    log.add(MethodCall(
        'getPreferences', <Object>[...?parameters.filter.allowList]));
    return backend.getPreferences(parameters, options);
  }

  @override
  Future<String?> getString(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getString', <String>[key]));
    return backend.getString(key, options);
  }

  @override
  Future<List<String>?> getStringList(
      String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getStringList', <String>[key]));
    return backend.getStringList(key, options);
  }

  @override
  Future<bool> setBool(
      String key, bool value, SharedPreferencesOptions options) {
    log.add(MethodCall('setBool', <Object>[key, value]));
    return backend.setBool(key, value, options);
  }

  @override
  Future<bool> setDouble(
      String key, double value, SharedPreferencesOptions options) {
    log.add(MethodCall('setDouble', <Object>[key, value]));
    return backend.setDouble(key, value, options);
  }

  @override
  Future<bool> setInt(String key, int value, SharedPreferencesOptions options) {
    log.add(MethodCall('setInt', <Object>[key, value]));
    return backend.setInt(key, value, options);
  }

  @override
  Future<bool> setString(
      String key, String value, SharedPreferencesOptions options) {
    log.add(MethodCall('setString', <Object>[key, value]));
    return backend.setString(key, value, options);
  }

  @override
  Future<bool> setStringList(
      String key, List<String> value, SharedPreferencesOptions options) {
    log.add(MethodCall('setStringList', <Object>[key, value]));
    return backend.setStringList(key, value, options);
  }
}
