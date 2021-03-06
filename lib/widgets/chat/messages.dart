import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (ctx, AsyncSnapshot<User?> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                final chatDoc = chatDocs[index];
                // final chat = chatDoc.data();
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Messagebubble(
                    chatDoc['username'],
                    chatDoc['userImage'],
                    chatDoc['text'],
                    chatDoc['userId'] == streamSnapshot.data!.uid,
                    key: ValueKey(chatDoc.id),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
