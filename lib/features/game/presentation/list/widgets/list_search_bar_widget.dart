import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final TextEditingController searchController;
  final Function()? onSend;

  const ListSearchBar(this.context, {Key? key, required this.searchController, required this.onSend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              blurRadius: 24.0,
              offset: const Offset(8.0, 16.0),
              spreadRadius: -20),
        ],
      ),
      child: TextField(
        controller: searchController,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Search games',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6)),
          contentPadding: const EdgeInsets.all(20.0),
          fillColor: Theme.of(context).colorScheme.surface,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: onSend,
            // TODO: change icon to close
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 20.0,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        onEditingComplete: onSend,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
