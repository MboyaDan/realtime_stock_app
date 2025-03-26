import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_stock_analytics/models/market_index_model.dart';

class MarketProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<MarketIndexModel> _indices = [];
  bool _isLoading = true;

  List<MarketIndexModel> get indices => _indices;
  bool get isLoading => _isLoading;

  MarketProvider() {
    fetchMarketIndices();
  }

  void fetchMarketIndices() {
    _firestore.collection('market_indices').snapshots().listen((snapshot) {
      _indices = snapshot.docs.map((doc) => MarketIndexModel.fromFirestore(doc)).toList();
      _isLoading = false;
      notifyListeners();
    });
  }
}
