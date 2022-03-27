import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomError extends StatelessWidget {
  final String title;
  const CustomError({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.error.withOpacity(0.6)),
              textAlign: TextAlign.left),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: FaIcon(
              FontAwesomeIcons.faceFrownOpen,
              color: Theme.of(context).colorScheme.error.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
