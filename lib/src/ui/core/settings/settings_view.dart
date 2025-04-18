import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyw_start/src/ui/core/settings/view_models/settings_providers.dart';

/// Displays the various settings that can be customized by the user.
class SettingsView extends ConsumerWidget {
  const SettingsView({
    super.key,
  });

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var themeMode = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ThemeModeDropdown(),
          DefaultDevice(),
        ],
      ),
    );
  }
}

class ThemeModeDropdown extends ConsumerWidget {
  const ThemeModeDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(
          'Application Theme : ',
        ),
        trailing: DropdownButton<ThemeMode>(
          value: ref.watch(themeProvider),
          onChanged: (ThemeMode? value) {
            ref
                .read(themeProvider.notifier)
                .updateTheme(value ?? ThemeMode.system);
          },
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}

class DefaultDevice extends ConsumerWidget {
  const DefaultDevice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text('Default Device : '),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text('FFAA1234'),
        ),
      ),
    );
  }
}
