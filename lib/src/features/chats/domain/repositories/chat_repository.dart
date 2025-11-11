import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {
  Stream<QuerySnapshot> getChats(String userId);
  Stream<QuerySnapshot> getMessages(String chatId);
  Future<void> sendMessage(String chatId, Map<String, dynamic> messageData);
}
