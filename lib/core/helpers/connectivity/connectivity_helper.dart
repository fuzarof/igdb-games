import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:igdb_games/core/services/navigation/navigation_handler.dart';
import 'package:igdb_games/core/widgets/connectivity_flushbar/connectivity_flushbar.dart';

abstract class IConnectivityHelper {
  Future<void> init();
  Future<void> close();
  Future<bool> isConnected();
}

class ConnectivityHelper implements IConnectivityHelper {
  StreamSubscription<ConnectivityResult>? subscription;
  final NavigationHandler _navigationHandler;

  ConnectivityHelper(this._navigationHandler);

  @override
  Future<bool> isConnected() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return [ConnectivityResult.mobile, ConnectivityResult.wifi, ConnectivityResult.ethernet]
          .contains(connectivityResult);
    } catch (err) {
      debugPrint('Error reading connectivity: $err');
      return false;
    }
  }

  @override
  Future<void> init() async {
    try {
      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          BuildContext context = _navigationHandler.appGlobalKey.currentContext!;
          ConnectivityFlushbar(context).show(context);
        }
      });
    } catch (err) {
      debugPrint('Error listening connectivity: $err');
    }
  }

  @override
  Future<void> close() async {
    try {
      if (subscription != null) subscription!.cancel();
    } catch (err) {
      debugPrint('Error closing connectivity: $err');
    }
  }
}
