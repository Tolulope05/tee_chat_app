import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8),
          child: const Text('This works'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/VRMylMIRgMs6OC9MKHot/messages')
              .snapshots()
              .listen(
            (data) {
              // print(data.docs[0]['text']);
              data.docs.forEach((document) {
                print(document['text']);
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
