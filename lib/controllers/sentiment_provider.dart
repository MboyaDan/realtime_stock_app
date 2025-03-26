import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_stock_analytics/models/sentiment_model.dart';

class SentimentProvider with ChangeNotifier {
  SentimentModel _sentiment = SentimentModel(score: 0.0);
  bool _isLoading = true;

  SentimentModel get sentiment => _sentiment;
  bool get isLoading => _isLoading;

  SentimentProvider() {
    fetchSentimentScore();
  }

  Future<void> fetchSentimentScore() async {
    try {
      FirebaseFirestore.instance
          .collection('sentiment_analysis')
          .doc('current_sentiment')
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          _sentiment = SentimentModel.fromMap(snapshot.data() ?? {});
          _isLoading = false;
          notifyListeners();
        }
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
