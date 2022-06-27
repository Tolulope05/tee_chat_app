import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final String message;
  final bool isMe;
  const Messagebubble(this.message, this.isMe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Colors.blueGrey[50]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(12),
            ),
          ),
          width: MediaQuery.of(context).size.width / 3,

          // width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color: isMe
                    ? Colors.black87
                    : Theme.of(context).textTheme.headline1!.color,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
