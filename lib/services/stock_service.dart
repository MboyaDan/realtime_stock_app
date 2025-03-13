import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class StockService {
  static const String _apiKey = '9IRBDG1S8KI5PKJT';
  static const String _baseUrl = 'https://www.alphavantage.co/query';

  // Cache to store stock prices temporarily
  static final Map<String, List<double>> _cachedPrices = {};
  static DateTime _lastApiCall = DateTime.now().subtract(const Duration(minutes: 1));

  /// Fetch stock prices from Alpha Vantage
  static Future<List<double>> fetchStockPrices(String symbol) async {
    if (_cachedPrices.containsKey(symbol)) {
      print("Returning cached data for $symbol");
      return _cachedPrices[symbol]!;
    }

    // Enforce rate limit (5 requests per minute)
    final timeSinceLastCall = DateTime.now().difference(_lastApiCall);
    if (timeSinceLastCall < const Duration(seconds: 12)) {
      print("Rate limiting: Waiting before next request...");
      await Future.delayed(const Duration(seconds: 12));
    }

    final url = Uri.parse("$_baseUrl?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$_apiKey");

    try {
      final response = await http.get(url);
      print("API Response for $symbol: ${response.body}"); // Debugging output

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Handle rate limit error
        if (data.containsKey("Note")) {
          print("API rate limit exceeded: ${data["Note"]}");
          return [];
        }

        final dynamic timeSeriesRaw = data["Time Series (5min)"];
        if (timeSeriesRaw == null || timeSeriesRaw is! Map<String, dynamic>) {
          print("No valid time series data found for $symbol");
          return [];
        }

        //Corrected Parsing with Explicit Casting
        final Map<String, dynamic> timeSeries = Map<String, dynamic>.from(timeSeriesRaw);
        List<double> prices = timeSeries.entries.map((entry) {
          final openPrice = entry.value["1. open"];
          return openPrice != null ? double.tryParse(openPrice) ?? 0.0 : 0.0;
        }).where((price) => price > 0).toList(); // Filter invalid values

        // Cache data
        _cachedPrices[symbol] = prices;
        _lastApiCall = DateTime.now();

        return prices;
      } else {
        throw Exception("Failed to load stock data");
      }
    } catch (e) {
      print("Error fetching stock data for $symbol: $e");
      return [];
    }
  }
}
