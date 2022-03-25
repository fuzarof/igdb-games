import 'package:equatable/equatable.dart';
import 'package:igdb_games/core/helpers/constants/constants.dart';
import 'package:igdb_games/core/helpers/dotenv/dotenv_helper.dart';
import 'package:igdb_games/injection_container.dart';

class GameImage extends Equatable {
  final int id;
  final String imageId;

  const GameImage({required this.id, required this.imageId});

  factory GameImage.fromJson(Map<String, dynamic> json) {
    String imageId = json['image_id'];
    return GameImage(
      id: json['id'],
      imageId: imageId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_id': imageId,
      };

  @override
  List<Object?> get props => [id, imageId];
}

class GameCover extends GameImage {
  final String thumbnail;
  final String cover;

  const GameCover({required id, required imageId, required this.thumbnail, required this.cover})
      : super(id: id, imageId: imageId);

  factory GameCover.fromJson(Map<String, dynamic> json) {
    String imageId = json['image_id'];
    String imagesUrl = inject.get<IDotEnvHelper>().getValue(Constants().envConstants.igdbImagesUrl);
    return GameCover(
      id: json['id'],
      imageId: imageId,
      thumbnail: '$imagesUrl/igdb/image/upload/t_thumb/$imageId.jpg',
      cover: '$imagesUrl/igdb/image/upload/t_cover_big/$imageId.jpg',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonSuper = super.toJson();
    jsonSuper['thumbnail'] = thumbnail;
    jsonSuper['cover'] = cover;
    return jsonSuper;
  }

  @override
  List<Object?> get props => [id, imageId, thumbnail, cover];
}

class GameScreenshot extends GameImage {
  final String screenshot;

  const GameScreenshot({required id, required imageId, required this.screenshot})
      : super(id: id, imageId: imageId);

  factory GameScreenshot.fromJson(Map<String, dynamic> json) {
    String imageId = json['image_id'];
    String imagesUrl = inject.get<IDotEnvHelper>().getValue(Constants().envConstants.igdbImagesUrl);
    return GameScreenshot(
      id: json['id'],
      imageId: imageId,
      screenshot: '$imagesUrl/igdb/image/upload/t_screenshot_big/$imageId.jpg',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonSuper = super.toJson();
    jsonSuper['screenshot'] = screenshot;
    return jsonSuper;
  }

  @override
  List<Object?> get props => [id, imageId, screenshot];
}
