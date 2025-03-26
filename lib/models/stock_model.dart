class Stock {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final double priceChange;
  final bool isMarketOpen;
  final List<double> historicalPrices;

  Stock({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChange,
    required this.isMarketOpen,
    required this.historicalPrices,
  });

  // Factory method to create a Stock object from Firestore data
  factory Stock.fromMap(Map<String, dynamic> data, String docId) {
    return Stock(
      id: docId, // Assign Firestore document ID
      name: data['name'] ?? '',
      symbol: data['symbol'] ?? '',
      currentPrice: (data['currentPrice'] ?? 0.0).toDouble(),
      priceChange: (data['priceChange'] ?? 0.0).toDouble(),
      isMarketOpen: data['isMarketOpen'] ?? false,
      historicalPrices: (data['historicalPrices'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
    );
  }

  // Convert Stock object to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'symbol': symbol,
      'currentPrice': currentPrice,
      'priceChange': priceChange,
      'isMarketOpen': isMarketOpen,
      'historicalPrices': historicalPrices,
    };
  }
}
