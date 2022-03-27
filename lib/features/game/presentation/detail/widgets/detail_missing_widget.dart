import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailMissing extends StatelessWidget {
  const DetailMissing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Empty', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: FaIcon(
            FontAwesomeIcons.faceFrownOpen,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            size: 16.0,
          ),
        ),
      ],
    );
  }
}
