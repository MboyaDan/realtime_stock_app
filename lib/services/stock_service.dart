import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stock_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch real-time stock prices
  Stream<List<Stock>> getRealTimeStockPrices() {
    return _db.collection('stocks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Stock.fromMap(doc.data())).toList();
    });
  }
}
