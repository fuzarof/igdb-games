import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';
import 'package:shimmer/shimmer.dart';

class GameCardWidget extends StatelessWidget {
  final Game game;
  final bool shimmer;

  const GameCardWidget({Key? key, required this.game, this.shimmer = false}) : super(key: key);

  buildPlatformLogo(BuildContext context, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FaIcon(icon, size: 20.0, color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
    );
  }

  _cardContent(BuildContext context) => Row(
        children: [
          Flexible(
            flex: 4,
            child: game.cover != null && game.id != const Game.dummy().id
                ? Hero(
                    tag: "hero-tag-${game.id}",
                    child: ExtendedImage.network(
                      game.cover!.cover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cache: true,
                    ),
                  )
                : Image.asset(
                    'assets/image-placeholder.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: shimmer
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const SizedBox(
                            height: 20,
                            width: double.infinity,
                          ),
                        ),
                        Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const SizedBox(
                            height: 30,
                            width: double.infinity,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const SizedBox(
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          game.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          game.summary ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Visibility(
                          visible: game.platforms?.isNotEmpty ?? false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ['PS1', 'PS2', 'PS3', 'PS4', 'PS5'].any((platform) =>
                                      game.platforms?.map((p) => p.abbreviation).contains(platform) ?? false)
                                  ? buildPlatformLogo(context, FontAwesomeIcons.playstation)
                                  : Container(),
                              ['XSX', 'XBOX', 'X360'].any((platform) =>
                                      game.platforms?.map((p) => p.abbreviation).contains(platform) ?? false)
                                  ? buildPlatformLogo(context, FontAwesomeIcons.xbox)
                                  : Container(),
                              [
                                'PC',
                              ].any((platform) =>
                                      game.platforms?.map((p) => p.abbreviation).contains(platform) ?? false)
                                  ? buildPlatformLogo(context, FontAwesomeIcons.windows)
                                  : Container(),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: SizedBox(
        height: 200,
        child: shimmer
            ? Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                child: _cardContent(context),
              )
            : _cardContent(context),
      ),
    );
  }
}
