import 'package:floor/floor.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';

@dao
abstract class GameDao {
  @Query('SELECT * FROM game WHERE name LIKE :search LIMIT :limit OFFSET :offset')
  Future<List<Game>> findGamesLike(String search, int limit, int offset);

  @Query('SELECT * FROM game WHERE id IN (:ids) LIMIT :limit OFFSET :offset')
  Future<List<Game>> findGamesInId(List<int> ids, int limit, int offset);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGames(List<Game> game);
}
