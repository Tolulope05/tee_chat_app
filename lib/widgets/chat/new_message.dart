import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _messageController.text,
        'createdAt': Timestamp.now(),
        'userId': user!.uid,
      },
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('New Message'),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
              semanticLabel: 'Send Message',
            ),
            onPressed: () {
              if (_messageController.text.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ],
      ),
    );
  }
}
