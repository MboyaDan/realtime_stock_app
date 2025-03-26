import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class NewsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<NewsModel> _newsList = [];
  bool _isLoading = false;

  List<NewsModel> get newsList => _newsList;

  //exposing only getter to prevent modifications
  bool get isLoading => _isLoading;
  // Fetch news from Firestore
  Future<void> fetchNews() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore.collection('news').orderBy('timeAgo', descending: true).get();
      _newsList = snapshot.docs.map((doc) => NewsModel.fromMap(doc.data() as Map<String, dynamic>)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print("Error fetching news: $error");
    }
  }
}