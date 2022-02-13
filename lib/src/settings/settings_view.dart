import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton<ThemeMode>(
                  // Read the selected themeMode from the controller
                  value: controller.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: controller.updateThemeMode,
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
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      'Режим оформления приложения',
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            'вы уверены что хотите удалить все данные?'),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                //  box.delete(currentTrack.id);
                                //    Navigator.of(context).pop(true);
                                //    context
                                //        .read<MemberListCubit>()
                                //       .clearAllMembers();
                              },
                              child: const Text('Выполнить')),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('Отменить'))
                        ],
                      );
                    },
                  );
                },
                child: const Text('Очистить все данные')),
          ],
        ),
      ),
    );
  }
}
