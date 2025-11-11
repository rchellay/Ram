import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/features/chats/presentation/providers/chat_provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    // Replace 'userId' with the actual user ID
    final String userId = 'some_user_id';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatProvider.getChats(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBon7V1Je8S84kSmxWhVEWcyvRpbGNo7EQBI6RET2wAteQjWAdR-S5gzNlmqUysRDr7hnDShzWVIRYPz_HaYhlTZgXwyqk9QjnOWEtlhO1Oc9ZLJP6AZKt2y_qNa1ylv2VMLnDqQJGBlBbrYU17FsSVIhSAX7TPMVpENG_t2iFEw1v8tXNgAmawID6b6EmKOl5ViT0q4zUUmTgnGkAdfNb3jIwGNxBydUncQi74pr1Bjk0qvNdAj_j5PVbktYJ-JoT9p5R4jq95Qw'),
                ),
                title: Text(data['name'] ?? 'Chat'),
                subtitle: Text(data['lastMessage'] ?? ''),
                onTap: () => context.go('/chat/${document.id}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
