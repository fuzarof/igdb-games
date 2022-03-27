import 'package:flutter/material.dart';
import 'package:igdb_games/application/theme.dart';
import 'package:igdb_games/core/services/navigation_handler.dart';
import 'package:igdb_games/injection_container.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IGDB Games',
      theme: themeData,
      onGenerateRoute: inject.get<NavigationHandler>().appRoutes,
      navigatorKey: inject.get<NavigationHandler>().appGlobalKey,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
