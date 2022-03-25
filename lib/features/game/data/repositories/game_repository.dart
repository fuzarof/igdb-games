import 'package:flutter/material.dart';
import 'package:igdb_games/core/helpers/dio/igdb_custom_dio.dart';
import 'package:igdb_games/core/helpers/igdb_query/igdb_query_helper.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';

class GameRepository implements IGameRepository {
  final IGDBCustomDio _igdbCustomDio;

  GameRepository(this._igdbCustomDio);

  @override
  Future<List<Game>> getGames({
    required int page,
    String? search,
    Map<String, IGDBQueryData>? where,
  }) async {
    try {
      final List<String> fields = [
        'id',
        'name',
        'summary',
        'screenshots.id',
        'screenshots.image_id',
        'cover.id',
        'cover.image_id',
        'platforms.id',
        'platforms.abbreviation',
        'platforms.name',
      ];

      const int limit = 10;

      final String query = IGDBQueryHelper.buildQuery(
          fields: fields, search: search, where: where, limit: limit, offset: limit * (page - 1));

      final response = await _igdbCustomDio.post('/games', data: query);

      List<Game> result = [];

      if (response.data?.isNotEmpty) {
        for (var game in response.data) {
          result.add(Game.fromJson(game));
        }
      }

      return result;
    } catch (err) {
      debugPrint('Error getting games list: $err');
      rethrow;
    }
  }
}
