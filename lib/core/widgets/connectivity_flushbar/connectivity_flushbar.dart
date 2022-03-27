import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConnectivityFlushbar extends Flushbar {
  ConnectivityFlushbar(BuildContext context, {Key? key})
      : super(
            key: key,
            message: 'Your internet connection is slow. Data will be limited.',
            duration: const Duration(seconds: 3),
            flushbarStyle: FlushbarStyle.FLOATING,
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Theme.of(context).colorScheme.primary);
}
