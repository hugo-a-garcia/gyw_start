// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:gyw_start/src/app.dart';
// import 'package:gyw_start/src/ui/core/settings/settings_controller.dart';
// import 'fake_settings_service.dart';

// void main() {
//   group('ServiceController.updateThemeMode should', () {
//     test('Inform the service of the value', () async {
//       // Initialize
//       final service = FakeSettingService();
//       final controller = SettingsController(service);
//       await controller.loadSettings();

//       //Test
//       expect(controller.themeMode, ThemeMode.system);
//       expect(await service.themeMode(), ThemeMode.system);
//       await controller.updateThemeMode(ThemeMode.dark);
//       expect(controller.themeMode, ThemeMode.dark);
//       expect(await service.themeMode(), ThemeMode.dark);
//     });

//     testWidgets('Inform the UI fo the value', (WidgetTester tester) async {
//       // final service = FakeSettingService();
//       // final controller = SettingsController(service);
//       // await controller.loadSettings();
//       // final myApp = GYWStartApp(settingsController: controller);

//       // await tester.pumpWidget(myApp);
//       // expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
//       //     ThemeMode.system);

//       // await controller.updateThemeMode(ThemeMode.dark);

//       // await tester.pumpWidget(myApp);

//       // expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
//       //     ThemeMode.dark);
//     });
//   });
// }
