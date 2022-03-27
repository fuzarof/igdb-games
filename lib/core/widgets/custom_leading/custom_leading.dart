import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/injection_container.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 16.0),
      child: InkWell(
        onTap: inject.get<NavigationHandler>().pop,
        child: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
