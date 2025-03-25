class Stock {
  final String name;
  final String symbol;
  final double currentPrice;
  final double priceChange;
  final bool isMarketOpen;
  final List<double> historicalPrices;

  Stock({
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChange,
    required this.isMarketOpen,
    required this.historicalPrices,
  });

  // Factory method to create Stock from a map (useful for Firestore)
  factory Stock.fromMap(Map<String, dynamic> data) {
    return Stock(
      name: data['name'] ?? '',
      symbol: data['symbol'] ?? '',
      currentPrice: (data['currentPrice'] ?? 0.0).toDouble(),
      priceChange: (data['priceChange'] ?? 0.0).toDouble(),
      isMarketOpen: data['isMarketOpen'] ?? false,
      historicalPrices: List<double>.from(data['historicalPrices'] ?? []),
    );
  }

  // Convert Stock object to a Map (useful for Firestore)
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
