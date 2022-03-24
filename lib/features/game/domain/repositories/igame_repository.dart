import 'package:igdb_games/features/game/data/models/game_model.dart';

abstract class IGameRepository {
  Future<List<Game>> getGames();
}
