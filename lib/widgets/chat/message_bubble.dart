import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  const Messagebubble(this.username, this.userImage, this.message, this.isMe,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _text(String text) {
      return Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isMe
              ? Colors.black87
              : Theme.of(context).textTheme.headline1!.color,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.blueGrey[50]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: MediaQuery.of(context).size.width / 3,

              // width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _text(username),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black87
                            : Theme.of(context).textTheme.headline1!.color,
                        fontWeight: FontWeight.w500),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            radius: 13,
            backgroundColor: isMe ? Colors.blueGrey[50] : Colors.green,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
