import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gyw_start/src/app.dart';
import 'package:gyw_start/src/settings/settings_controller.dart';
import 'package:gyw_start/src/settings/settings_service.dart';
import 'package:shared_preferences/src/shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';

class FakeSettingService implements SettingsService {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  SharedPreferencesAsync get prefs => SharedPreferencesAsync();

  // Loads the User's preferred ThemeMode from local or remote storage.
  @override
  Future<ThemeMode> themeMode() async => _themeMode;

  // Persists the user's preferred ThemeMode to local or remote storage.
  @override
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    _themeMode = theme;
  }
}

void main() {
  const String stringKey = 'testString';
  const String boolKey = 'testBool';
  const String intKey = 'testInt';
  const String doubleKey = 'testDouble';
  const String listKey = 'testList';

  const String testString = 'hello world';
  const bool testBool = true;
  const int testInt = 42;
  const double testDouble = 3.14159;
  const List<String> testList = <String>['foo', 'bar'];

  group('ServiceController.updateThemeMode should', () {
    test('Inform the service of the value', () async {
      // Initialize
      final service = FakeSettingService();
      final controller = SettingsController(service);
      await controller.loadSettings();

      //Test
      expect(controller.themeMode, ThemeMode.system);
      expect(service._themeMode, ThemeMode.system);
      await controller.updateThemeMode(ThemeMode.dark);
      expect(controller.themeMode, ThemeMode.dark);
      expect(service._themeMode, ThemeMode.dark);
    });

    testWidgets('Inform the UI fo the value', (WidgetTester tester) async {
      final service = FakeSettingService();
      final controller = SettingsController(service);
      await controller.loadSettings();
      final myApp = MyApp(settingsController: controller);

      await tester.pumpWidget(myApp);
      expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
          ThemeMode.system);

      await controller.updateThemeMode(ThemeMode.dark);

      await tester.pumpWidget(myApp);

      expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
          ThemeMode.dark);
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

    test('set and get bool', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await preferences.setBool(boolKey, testBool);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('setBool', arguments: <dynamic>[
            boolKey,
            testBool,
          ]),
        ],
      );
      store.log.clear();
      expect(await preferences.getBool(boolKey), testBool);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('getBool', arguments: <dynamic>[
            boolKey,
          ]),
        ],
      );
    });

    test('set and get int', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await preferences.setInt(intKey, testInt);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('setInt', arguments: <dynamic>[
            intKey,
            testInt,
          ]),
        ],
      );
      store.log.clear();

      expect(await preferences.getInt(intKey), testInt);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('getInt', arguments: <dynamic>[
            intKey,
          ]),
        ],
      );
    });

    test('set and get double', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await preferences.setDouble(doubleKey, testDouble);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('setDouble', arguments: <dynamic>[
            doubleKey,
            testDouble,
          ]),
        ],
      );
      store.log.clear();
      expect(await preferences.getDouble(doubleKey), testDouble);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('getDouble', arguments: <dynamic>[
            doubleKey,
          ]),
        ],
      );
    });

    test('set and get StringList', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await preferences.setStringList(listKey, testList);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('setStringList', arguments: <dynamic>[
            listKey,
            testList,
          ]),
        ],
      );
      store.log.clear();
      expect(await preferences.getStringList(listKey), testList);
      expect(
        store.log,
        <Matcher>[
          isMethodCall('getStringList', arguments: <dynamic>[
            listKey,
          ]),
        ],
      );
    });

    test('getAll', () async {
      final (SharedPreferencesAsync preferences, _) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);

      final Map<String, Object?> gotAll = await preferences.getAll();

      expect(gotAll.length, 5);
      expect(gotAll[stringKey], testString);
      expect(gotAll[boolKey], testBool);
      expect(gotAll[intKey], testInt);
      expect(gotAll[doubleKey], testDouble);
      expect(gotAll[listKey], testList);
    });

    test('getAll with filter', () async {
      final (SharedPreferencesAsync preferences, _) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);

      final Map<String, Object?> gotAll =
          await preferences.getAll(allowList: <String>{stringKey, boolKey});

      expect(gotAll.length, 2);
      expect(gotAll[stringKey], testString);
      expect(gotAll[boolKey], testBool);
    });

    test('remove', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      const String key = 'testKey';
      await preferences.remove(key);
      expect(
          store.log,
          List<Matcher>.filled(
            1,
            isMethodCall(
              'clear',
              arguments: <String>[key],
            ),
            growable: true,
          ));
    });

    test('getKeys', () async {
      final (SharedPreferencesAsync preferences, _) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);

      final Set<String> keys = await preferences.getKeys();

      expect(keys.length, 5);
      expect(keys, contains(stringKey));
      expect(keys, contains(boolKey));
      expect(keys, contains(intKey));
      expect(keys, contains(doubleKey));
      expect(keys, contains(listKey));
    });

    test('getKeys with filter', () async {
      final (SharedPreferencesAsync preferences, _) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);

      final Set<String> keys =
          await preferences.getKeys(allowList: <String>{stringKey, boolKey});

      expect(keys.length, 2);
      expect(keys, contains(stringKey));
      expect(keys, contains(boolKey));
    });

    test('containsKey', () async {
      final (SharedPreferencesAsync preferences, _) = getPreferences();
      const String key = 'testKey';

      expect(false, await preferences.containsKey(key));

      await preferences.setString(key, 'test');
      expect(true, await preferences.containsKey(key));
    });

    test('clear', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);
      store.log.clear();
      await preferences.clear();
      expect(
          store.log, <Matcher>[isMethodCall('clear', arguments: <Object>[])]);
      expect(await preferences.getString(stringKey), null);
      expect(await preferences.getBool(boolKey), null);
      expect(await preferences.getInt(intKey), null);
      expect(await preferences.getDouble(doubleKey), null);
      expect(await preferences.getStringList(listKey), null);
    });

    test('clear with filter', () async {
      final (
        SharedPreferencesAsync preferences,
        FakeSharedPreferencesAsync store
      ) = getPreferences();
      await Future.wait(<Future<void>>[
        preferences.setString(stringKey, testString),
        preferences.setBool(boolKey, testBool),
        preferences.setInt(intKey, testInt),
        preferences.setDouble(doubleKey, testDouble),
        preferences.setStringList(listKey, testList)
      ]);
      store.log.clear();
      await preferences.clear(allowList: <String>{stringKey, boolKey});
      expect(store.log, <Matcher>[
        isMethodCall('clear', arguments: <Object>[stringKey, boolKey])
      ]);
      expect(await preferences.getString(stringKey), null);
      expect(await preferences.getBool(boolKey), null);
      expect(await preferences.getInt(intKey), testInt);
      expect(await preferences.getDouble(doubleKey), testDouble);
      expect(await preferences.getStringList(listKey), testList);
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
