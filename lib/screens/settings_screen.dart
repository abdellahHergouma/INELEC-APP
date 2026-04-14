import 'package:flutter/material.dart';

import '../theme_config.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.themeModeNotifier,
    required this.themeChoiceNotifier,
  });

  final ValueNotifier<ThemeMode> themeModeNotifier;
  final ValueNotifier<AppColorTheme> themeChoiceNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.school, color: Colors.white, size: 30),
            const SizedBox(width: 8),
            const Text('Settings'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Display Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeModeNotifier,
              builder: (context, mode, child) {
                return RadioGroup<ThemeMode>(
                  groupValue: mode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      themeModeNotifier.value = value;
                    }
                  },
                  child: Column(
                    children: const [
                      RadioListTile<ThemeMode>(
                        title: Text('Light Mode'),
                        value: ThemeMode.light,
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text('Dark Mode'),
                        value: ThemeMode.dark,
                      ),
                      RadioListTile<ThemeMode>(
                        title: Text('System Default'),
                        value: ThemeMode.system,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Color Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<AppColorTheme>(
              valueListenable: themeChoiceNotifier,
              builder: (context, selectedTheme, child) {
                return Column(
                  children: [
                    RadioListTile<AppColorTheme>(
                      title: const Text('Green Theme'),
                      value: AppColorTheme.green,
                      groupValue: selectedTheme,
                      onChanged: (value) {
                        if (value != null) {
                          themeChoiceNotifier.value = value;
                        }
                      },
                    ),
                    RadioListTile<AppColorTheme>(
                      title: const Text('Purple Theme'),
                      value: AppColorTheme.purple,
                      groupValue: selectedTheme,
                      onChanged: (value) {
                        if (value != null) {
                          themeChoiceNotifier.value = value;
                        }
                      },
                    ),
                    RadioListTile<AppColorTheme>(
                      title: const Text('Blue Theme'),
                      value: AppColorTheme.blue,
                      groupValue: selectedTheme,
                      onChanged: (value) {
                        if (value != null) {
                          themeChoiceNotifier.value = value;
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
