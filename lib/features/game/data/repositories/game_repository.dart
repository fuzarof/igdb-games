import 'package:flutter/material.dart';
import 'package:igdb_games/core/helpers/connectivity/connectivity_helper.dart';
import 'package:igdb_games/core/helpers/database/database.dart';
import 'package:igdb_games/core/helpers/igdb_query/igdb_query_helper.dart';
import 'package:igdb_games/core/services/dio/igdb_custom_dio.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:igdb_games/features/game/domain/repositories/igame_repository.dart';

class GameRepository implements IGameRepository {
  final IGDBCustomDio _igdbCustomDio;
  final IDatabaseHelper _databaseHelper;
  final IConnectivityHelper _connectivityHelper;

  GameRepository(this._igdbCustomDio, this._databaseHelper, this._connectivityHelper);

  @override
  Future<List<Game>> getGames({
    required int page,
    String? search,
    List<int>? inIds,
  }) async {
    final gameDao = _databaseHelper.database!.gameDao;
    const int limit = 10;
    try {
      if (await _connectivityHelper.isConnected()) {
        final List<String> fields = [
          'id',
          'name',
          'summary',
          'screenshots.id',
          'screenshots.image_id',
          'cover.id',
          'cover.image_id',
          'aggregated_rating',
          'platforms.id',
          'platforms.abbreviation',
          'platforms.name',
          'similar_games.id',
        ];

        final String query = IGDBQueryHelper.buildQuery(
            fields: fields, search: search, inIds: inIds, limit: limit, offset: limit * (page - 1));

        final response = await _igdbCustomDio.post('/games', data: query);

        List<Game> result = [];

        if (response.data?.isNotEmpty) {
          for (var game in response.data) {
            result.add(Game.fromJson(game));
          }
        }

        await gameDao.insertGames(result);

        return result;
      } else {
        List<Game> result = [];
        if (inIds != null) {
          result = await gameDao.findGamesInId(inIds, limit, limit * (page - 1));
        } else {
          result = await gameDao.findGamesLike("%${search ?? ''}%", limit, limit * (page - 1));
        }
        return result;
      }
    } catch (err) {
      debugPrint('Error getting games list: $err');
      rethrow;
    }
  }
}
