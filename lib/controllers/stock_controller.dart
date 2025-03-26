import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/stock_model.dart';

class StockProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Stock> _stocks = [];
  List<Stock> _trendingStocks = [];
  bool _isLoading = true;

  List<Stock> get stocks => _stocks;
  List<Stock> get trendingStocks => _trendingStocks;
  bool get isLoading => _isLoading;

  StockProvider() {
    fetchRealTimeStocks();
  }

  void fetchRealTimeStocks() {
    _db.collection('stocks').snapshots().listen(
          (snapshot) {
        _stocks = snapshot.docs
            .map((doc) => Stock.fromMap(doc.data(), doc.id))
            .toList();
        _updateTrendingStocks();
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        debugPrint("🔥 Error fetching stocks: $error");
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void _updateTrendingStocks() {
    _trendingStocks = _stocks.where((stock) => stock.priceChange > 0).toList();
  }
}
