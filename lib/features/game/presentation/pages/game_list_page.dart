import 'package:flutter/material.dart';

class GameListPage extends StatefulWidget {
  static const String route = "/";

  const GameListPage({Key? key}) : super(key: key);

  @override
  State<GameListPage> createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IGDB Games")),
    );
  }
}
