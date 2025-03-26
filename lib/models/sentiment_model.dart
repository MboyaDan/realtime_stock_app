class SentimentModel {
  final double score;

  SentimentModel({required this.score});

  // Factory method to create a SentimentModel from Firestore data
  factory SentimentModel.fromMap(Map<String, dynamic> data) {
    return SentimentModel(
      score: data['score']?.toDouble() ?? 0.0, // Ensure it's a double
    );
  }
}
