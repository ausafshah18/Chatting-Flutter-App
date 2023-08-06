import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();
    // to reset the input

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    // making a get request to get data of a particular user from Firestore DB. userData is a document containing a Map. We did this get request to get username and userimage from Firestore

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userimage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 15),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            // every sentence begins with a capital letter
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(labelText: 'Send a message...'),
          ),
        ),
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: _submitMessage,
          icon: const Icon(
            Icons.send,
          ),
        )
      ]),
    );
  }
}