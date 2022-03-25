import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold(BuildContext context, {Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
        Theme.of(context).colorScheme.background,
        Theme.of(context).colorScheme.onPrimary,
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: key,
        body: body,
      ),
    );
  }
}
