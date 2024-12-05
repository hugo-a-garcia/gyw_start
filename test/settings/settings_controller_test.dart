import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gyw_start/src/app.dart';
import 'package:gyw_start/src/settings/settings_controller.dart';
import 'package:gyw_start/src/settings/settings_service.dart';

class FakeSettingService implements SettingsService {
  ThemeMode _themeMode = ThemeMode.system;

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
}
