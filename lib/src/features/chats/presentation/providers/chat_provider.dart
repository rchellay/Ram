import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spymatch/src/features/chats/data/repositories/firestore_chat_repository.dart';

class ChatProvider with ChangeNotifier {
  final FirestoreChatRepository _chatRepository;

  ChatProvider({required FirestoreChatRepository chatRepository})
      : _chatRepository = chatRepository;

  Stream<QuerySnapshot> getChats(String userId) =>
      _chatRepository.getChats(userId);

  Stream<QuerySnapshot> getMessages(String chatId) =>
      _chatRepository.getMessages(chatId);

  Future<void> sendMessage(String chatId, Map<String, dynamic> messageData) async {
    await _chatRepository.sendMessage(chatId, messageData);
  }
}
