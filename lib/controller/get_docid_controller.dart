import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDocIdController extends ChangeNotifier {
  final userName = FirebaseFirestore.instance.collection('users');
  late List<String> docIDs = [];
  bool ordeByDescending = true;

  Future getDocId() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: ordeByDescending)
        .get();
    docIDs = snapshot.docs.map((document) => document.reference.id).toList();
    ordeByDescending = !ordeByDescending;
    notifyListeners();
  }
}
