import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MissionRepository {
  Future<void> createMission(Map<String, dynamic> missionData);
  Stream<QuerySnapshot> getMissions();
  Future<void> acceptMission(String missionId, String userId);
}
