import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const DetailTitle({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24.0),
      width: double.infinity,
      child: Row(
        children: [
          FaIcon(
            icon,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }
}
