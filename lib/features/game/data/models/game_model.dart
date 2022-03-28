import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:igdb_games/features/game/data/models/game_image_model.dart';
import 'package:igdb_games/features/game/data/models/game_platform_model.dart.dart';

@Entity(tableName: 'game')
class Game extends Equatable {
  @primaryKey
  final int id;
  final String? name;
  final String? summary;
  final GameCover? cover;
  final double? aggregatedRating;
  final List<GameScreenshot>? screenshots;
  final List<GamePlatform>? platforms;
  final List<int>? similarGames;

  const Game(
      {required this.id,
      this.name,
      this.summary,
      this.aggregatedRating,
      this.cover,
      this.screenshots,
      this.platforms,
      this.similarGames});

  const Game.dummy(
      {this.id = 0,
      this.name,
      this.summary,
      this.aggregatedRating,
      this.cover,
      this.screenshots,
      this.platforms,
      this.similarGames});

  factory Game.fromJson(Map<String, dynamic> json) {
    GameCover? cover;
    List<GameScreenshot>? screenshots;
    if (json['cover'] != null) cover = GameCover.fromJson(json['cover']);
    if (json['screenshots'] != null) {
      screenshots = [];
      for (var screenshot in json['screenshots']) {
        screenshots.add(GameScreenshot.fromJson(screenshot));
      }
    }
    List<GamePlatform>? platforms;
    if (json['platforms'] != null) {
      platforms = [];
      for (var platform in json['platforms']) {
        platforms.add(GamePlatform.fromJson(platform));
      }
    }
    Game newGame = Game(
      id: json['id'] ?? 0,
      name: json['name'],
      summary: json['summary'],
      similarGames: json['similar_games'] != null
          ? List<int>.from(
              List<Map<String, dynamic>>.from(json['similar_games']).map((e) => e['id']).toList())
          : null,
      aggregatedRating: json['aggregated_rating'],
      cover: cover,
      screenshots: screenshots,
      platforms: platforms,
    );
    return newGame;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {'id': id, 'name': name, 'summary': summary};
    json['cover'] = cover?.toJson();
    if (screenshots != null) {
      json['screenshots'] = [];
      for (var screenshot in screenshots!) {
        json['screenshots'].add(screenshot);
      }
    }
    if (platforms != null) {
      json['platforms'] = [];
      for (var platform in platforms!) {
        json['platforms'].add(platform);
      }
    }
    json['similar_games'] = similarGames;
    json['aggregated_rating'] = aggregatedRating;
    return json;
  }

  @override
  List<Object?> get props =>
      [id, name, summary, cover, aggregatedRating, screenshots, platforms, similarGames];
}
