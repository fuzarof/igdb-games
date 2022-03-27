import 'package:flutter/material.dart';
import 'package:igdb_games/features/game/presentation/detail/pages/game_details_page.dart';
import 'package:igdb_games/features/game/presentation/list/pages/game_list_page.dart';

class NavigationHandler {
  final GlobalKey<NavigatorState> appGlobalKey = GlobalKey();

  Route<dynamic> appRoutes(RouteSettings settings) {
    switch (settings.name) {
      case GameListPage.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return const GameListPage();
            });
      case GameDetailsPage.route:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
              return GameDetailsPage(
                game: arguments['game'],
                similarGame: arguments['similar_game'],
              );
            });
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              return Container();
            });
    }
  }

  Future<T?> push<T extends Object?>(
    String route, {
    Object? arguments,
  }) async {
    return Navigator.pushNamed(
      appGlobalKey.currentContext!,
      route,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([
    T? result,
  ]) {
    return Navigator.pop(appGlobalKey.currentContext!, result);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    String route,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      appGlobalKey.currentContext!,
      route,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object>(
    String route, {
    Object? arguments,
    Object? result,
  }) {
    return Navigator.pushReplacementNamed(
      appGlobalKey.currentContext!,
      route,
      arguments: arguments,
      result: result,
    );
  }
}
