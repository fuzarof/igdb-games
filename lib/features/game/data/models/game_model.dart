import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:igdb_games/features/game/data/models/game_image_model.dart';
import 'package:igdb_games/features/game/data/models/game_platform_model.dart.dart';

@Entity(tableName: 'game')
class Game extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String? summary;
  final GameCover? cover;
  final List<GameScreenshot>? screenshots;
  final List<GamePlatform>? platforms;

  const Game(
      {required this.id, required this.name, this.summary, this.cover, this.screenshots, this.platforms});

  const Game.dummy({this.id = 0, this.name = '', this.summary, this.cover, this.screenshots, this.platforms});

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
      id: json['id'],
      name: json['name'],
      summary: json['summary'],
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
    return json;
  }

  @override
  List<Object?> get props => [id, name, summary, cover, screenshots];
}
