import 'package:flutter/material.dart';
import 'package:napster_bloc/src/pages/artist_detail_page.dart';
import 'package:napster_bloc/src/pages/home_page.dart';
import 'package:napster_bloc/src/pages/splash.dart';
import 'package:napster_bloc/src/pages/unknown_scr.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Сначала загрузим начальный список артистов, а пока грузится покажем Splash
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MySplashWidget();
          }
          return AnimatedBuilder(
            animation: settingsController,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                restorationScopeId: 'myapp',
                debugShowCheckedModeBanner: false,
                darkTheme: ThemeData.dark(),
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                themeMode: settingsController.themeMode,
                onGenerateRoute: ((RouteSettings routeSettings) {
                  return MaterialPageRoute<void>(
                    settings: routeSettings,
                    builder: (BuildContext context) {
                      switch (routeSettings.name) {
                        case SettingsView.routeName:
                          return SettingsView(controller: settingsController);
                        case HomePage.routeName:
                          return const HomePage();
                        case ArtistDetail.routeName:
                          return const ArtistDetail();
                        default:
                          return const UnknownScreen();
                      }
                    },
                  );
                }),
                initialRoute: HomePage.routeName,
              );
            },
          );
        });
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }
}
