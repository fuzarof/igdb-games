import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';

class GameCardWidget extends StatelessWidget {
  final Game game;

  const GameCardWidget({Key? key, required this.game}) : super(key: key);

  buildPlatformLogo(BuildContext context, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FaIcon(icon, size: 20.0, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8)),
    );
  }

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
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: game.cover != null
                  ? Image.network(
                      game.cover!.cover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.asset(
                      'assets/image-placeholder.png',
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      game.name,
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
                          // TODO: fix this logic
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
                          buildPlatformLogo(context, FontAwesomeIcons.plus),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}