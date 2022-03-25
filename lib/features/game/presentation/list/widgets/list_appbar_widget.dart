import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/filter_modal_widget.dart';
import 'package:igdb_games/features/game/presentation/list/widgets/list_search_bar_widget.dart';

class ListAppBar extends SliverAppBar {
  ListAppBar(
    BuildContext context, {
    Key? key,
    Function(String)? onSend,
    required bool innerBoxIsScrolled,
    required TextEditingController searchController,
  }) : super(
          key: key,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.gamepad,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
              RichText(
                text: TextSpan(style: Theme.of(context).textTheme.titleLarge, children: [
                  TextSpan(
                    text: '  IGDB ',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const TextSpan(
                    text: 'Games',
                  ),
                ]),
              )
            ],
          ),
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 16.0),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return const FilterModal();
                    },
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.filter,
                  size: 20,
                  color: Theme.of(context).colorScheme.onBackground,
                ))
          ],
          floating: true,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          bottom: ListSearchBar(context, searchController: searchController, onSend: onSend),
        );
}
