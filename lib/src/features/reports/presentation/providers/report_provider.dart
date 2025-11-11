import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportProvider with ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ReportProvider({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  Future<void> createReport(Map<String, dynamic> reportData, File? mediaFile) async {
    if (mediaFile != null) {
      final ref = _storage.ref().child('reports').child('${DateTime.now()}.jpg');
      await ref.putFile(mediaFile);
      final url = await ref.getDownloadURL();
      reportData['mediaUrl'] = url;
    }
    await _firestore.collection('reports').add(reportData);
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
