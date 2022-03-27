import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:igdb_games/features/game/data/models/game_image_model.dart';
import 'package:igdb_games/features/game/data/models/game_platform_model.dart.dart';

class GameCoverTypeConverter extends TypeConverter<GameCover?, String?> {
  @override
  GameCover? decode(String? databaseValue) {
    return databaseValue != null ? GameCover.fromJson(jsonDecode(databaseValue)) : null;
  }

  @override
  String? encode(GameCover? value) {
    return value != null ? jsonEncode(value.toJson()) : null;
  }
}

class ListGameScreenshotTypeConverter extends TypeConverter<List<GameScreenshot>?, String?> {
  @override
  List<GameScreenshot>? decode(String? databaseValue) {
    List<GameScreenshot> resultList = [];
    if (databaseValue != null) {
      List<Map<String, dynamic>> itemList = List<Map<String, dynamic>>.from(jsonDecode(databaseValue));
      for (var item in itemList) {
        resultList.add(GameScreenshot.fromJson(item));
      }
      return resultList;
    }
    return null;
  }

  @override
  String? encode(List<GameScreenshot>? value) {
    if (value != null) {
      List<Map<String, dynamic>> itemList = [];
      for (var item in value) {
        itemList.add(item.toJson());
      }
      return jsonEncode(itemList);
    }
    return null;
  }
}

class ListGamePlatformTypeConverter extends TypeConverter<List<GamePlatform>?, String?> {
  @override
  List<GamePlatform>? decode(String? databaseValue) {
    List<GamePlatform> resultList = [];
    if (databaseValue != null) {
      List<Map<String, dynamic>> itemList = List<Map<String, dynamic>>.from(jsonDecode(databaseValue));
      for (var item in itemList) {
        resultList.add(GamePlatform.fromJson(item));
      }
      return resultList;
    }
    return null;
  }

  @override
  String? encode(List<GamePlatform>? value) {
    if (value != null) {
      List<Map<String, dynamic>> itemList = [];
      for (var item in value) {
        itemList.add(item.toJson());
      }
      return jsonEncode(itemList);
    }
    return null;
  }
}

class ListSimilarGamesTypeConverter extends TypeConverter<List<int>?, String?> {
  @override
  List<int>? decode(String? databaseValue) {
    List<int> resultList = [];
    if (databaseValue != null) {
      List<int> itemList = List<int>.from(jsonDecode(databaseValue));
      for (var item in itemList) {
        resultList.add(int.parse(item.toString()));
      }
      return resultList;
    }
    return null;
  }

  @override
  String? encode(List<int>? value) {
    if (value != null) {
      List<int> itemList = [];
      for (var item in value) {
        itemList.add(item);
      }
      return jsonEncode(itemList);
    }
    return null;
  }
}
