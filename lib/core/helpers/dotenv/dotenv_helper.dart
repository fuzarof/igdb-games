import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class IDotEnvHelper {
  String getValue(String key);
  Future<void> init();
}

class DotEnvHelper implements IDotEnvHelper {
  @override
  String getValue(String key) {
    try {
      return dotenv.env[key] ?? '';
    } catch (err) {
      debugPrint('Error getting dotenv variable: $err');
      return '';
    }
  }

  @override
  Future<void> init() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (err) {
      debugPrint('Error loading from dotenv: $err');
    }
  }
}
