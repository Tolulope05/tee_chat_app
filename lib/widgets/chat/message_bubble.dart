import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final String message;
  const Messagebubble(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width / 3,

          // width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
