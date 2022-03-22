import 'package:flutter/material.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/core/services/navigation_handler.dart';
import 'package:igdb_games/injection_container.dart';

Future<void> main() async {
  setup();
  await inject.get<IDotEnvHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
