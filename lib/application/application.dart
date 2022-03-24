import 'package:flutter/material.dart';
import 'package:igdb_games/core/services/navigation_handler.dart';
import 'package:igdb_games/injection_container.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IGDB',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      onGenerateRoute: inject.get<NavigationHandler>().appRoutes,
      initialRoute: '/',
    );
  }
}
