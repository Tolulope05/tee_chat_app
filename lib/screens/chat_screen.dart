import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/VRMylMIRgMs6OC9MKHot/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
          );
        },
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
