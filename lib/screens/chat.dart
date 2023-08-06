import 'package:chatting_app/widgets/chat_messages.dart';
import 'package:chatting_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                // Since. in the StreamBuilder()(in main.dart) we are listening to changes on authentication, so, after signing out it will automatically return auth.dart
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              )),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            // wrapping it in expanded so that ChatMessages() can take as much space as needed
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
