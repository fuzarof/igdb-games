import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:igdb_games/core/widgets/custom_scaffold/custom_leading.dart';
import 'package:igdb_games/features/game/data/models/game_model.dart';

class DetailAppbar extends SliverAppBar {
  DetailAppbar(
    BuildContext context, {
    Key? key,
    required bool innerBoxIsScrolled,
    required Game game,
  }) : super(
          key: key,
          expandedHeight: 280,
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          leading: const CustomLeading(),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Hero(
                      tag: game.id.toString(),
                      child: game.cover != null
                          ? ExtendedImage.network(
                              game.cover!.cover,
                              fit: BoxFit.cover,
                              height: 250,
                              width: 200,
                              cache: true,
                            )
                          : Image.asset(
                              'assets/image-placeholder.png',
                              fit: BoxFit.cover,
                              height: 250,
                              width: 200,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
