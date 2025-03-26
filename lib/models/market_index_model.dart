import 'package:cloud_firestore/cloud_firestore.dart';

class MarketIndexModel {
  final String name;
  final String value;
  final String change;

  MarketIndexModel({
    required this.name,
    required this.value,
    required this.change,
  });

  // Factory method to create a model from Firestore snapshot
  factory MarketIndexModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MarketIndexModel(
      name: data['name'] ?? '',
      value: data['value'] ?? '',
      change: data['change'] ?? '',
    );
  }
}
