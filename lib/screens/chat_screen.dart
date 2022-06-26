import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tee Chat'), actions: [
        DropdownButton(
          items: [
            DropdownMenuItem(
              value: 'logout',
              child: Row(
                children: const [
                  Icon(Icons.exit_to_app, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
          onChanged: (itemIdentifier) {
            if (itemIdentifier == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
      ]),
      body: SizedBox(
        child: Column(
          children: const [
            Expanded(child: Messages()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/VRMylMIRgMs6OC9MKHot/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
