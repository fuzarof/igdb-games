import 'package:igdb_games/core/helpers/igdb_query/igdb_query_helper.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';

abstract class IGameRepository {
  Future<List<Game>> getGames({
    int? page,
    String? search,
    Map<String, IGDBQueryData>? where,
  });
}
