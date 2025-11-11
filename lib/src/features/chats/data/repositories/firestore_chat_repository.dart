import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spymatch/src/features/chats/domain/repositories/chat_repository.dart';

class FirestoreChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore;

  FirestoreChatRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getChats(String userId) {
    return _firestore
        .collection('chats')
        .where('users', arrayContains: userId)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Future<void> sendMessage(String chatId, Map<String, dynamic> messageData) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);
  }
}
