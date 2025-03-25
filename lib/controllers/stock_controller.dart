import 'package:flutter/material.dart';
import '../models/stock_model.dart';
import '../services/stock_service.dart';

class StockProvider with ChangeNotifier{
  final FirestoreService _firestoreService = FirestoreService();
  List<Stock> _stocks = [];

  List<Stock>get stocks => _stocks;

  void fetchRealTimeStocks() {
    _firestoreService.getRealTimeStockPrices().listen((data) {
      _stocks = data;
      notifyListeners(); // Notify UI of updates
    });
  }
}