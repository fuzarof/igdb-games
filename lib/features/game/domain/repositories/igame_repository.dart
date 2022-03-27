import 'package:igdb_games/features/game/data/models/game_model.dart';

abstract class IGameRepository {
  Future<List<Game>> getGames({
    required int page,
    String? search,
    List<int>? inIds,
  });
}
