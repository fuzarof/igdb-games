import 'package:flutter/material.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 8,
            width: w * 0.3,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
