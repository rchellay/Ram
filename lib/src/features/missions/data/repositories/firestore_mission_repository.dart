import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spymatch/src/features/missions/domain/repositories/mission_repository.dart';

class FirestoreMissionRepository implements MissionRepository {
  final FirebaseFirestore _firestore;

  FirestoreMissionRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createMission(Map<String, dynamic> missionData) {
    return _firestore.collection('missions').add(missionData);
  }

  @override
  Stream<QuerySnapshot> getMissions() {
    return _firestore.collection('missions').snapshots();
  }

  @override
  Future<void> acceptMission(String missionId, String userId) {
    return _firestore.collection('missions').doc(missionId).update({
      'acceptedBy': userId,
      'status': 'accepted',
    });
  }
}
