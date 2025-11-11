import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spymatch/src/features/missions/data/repositories/firestore_mission_repository.dart';

class MissionProvider with ChangeNotifier {
  final FirestoreMissionRepository _missionRepository;

  MissionProvider({required FirestoreMissionRepository missionRepository})
      : _missionRepository = missionRepository;

  Stream<QuerySnapshot> get missions => _missionRepository.getMissions();

  Future<void> createMission(Map<String, dynamic> missionData) async {
    await _missionRepository.createMission(missionData);
  }

  Future<void> acceptMission(String missionId, String userId) async {
    await _missionRepository.acceptMission(missionId, userId);
  }
}
