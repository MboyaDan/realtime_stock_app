import 'package:flutter/material.dart';
import 'package:realtime_stock_analytics/services/stock_service.dart';
import 'package:realtime_stock_analytics/widgets/stock_card.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({Key? key}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> stockList = [];
  bool isLoading = true;

  final List<String> stockSymbols = ["AAPL", "TSLA", "GOOGL", "MSFT"];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    fetchStockList();
  }

  void fetchStockList() async {
    try {
      List<Map<String, dynamic>> stocks = [];

      for (String symbol in stockSymbols) {
        List<double> prices = await StockService.fetchStockPrices(symbol);
        if (prices.isNotEmpty) {
          stocks.add({
            "name": getStockName(symbol),
            "symbol": symbol,
            "price": prices.last,
            "change": (prices.last - prices.first).toStringAsFixed(2),
            "isOpen": true, // Can be updated dynamically
          });
        }
      }

      setState(() {
        stockList = stocks;
        isLoading = false;
      });

      _controller.forward(); // Trigger fade-in animation after fetching data
    } catch (e) {
      print("Error fetching stock data: $e");
      setState(() => isLoading = false);
    }
  }

  String getStockName(String symbol) {
    final Map<String, String> stockNames = {
      "AAPL": "Apple Inc.",
      "TSLA": "Tesla, Inc.",
      "GOOGL": "Alphabet Inc.",
      "MSFT": "Microsoft Corp."
    };
    return stockNames[symbol] ?? "Unknown Stock";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          itemCount: stockList.length,
          itemBuilder: (context, index) {
            final stock = stockList[index];
            return Hero(
              tag: "stock_${stock['symbol']}", // Unique hero tag per stock
              child: StockCard(
                stockName: stock["name"],
                stockSymbol: stock["symbol"],
                currentPrice: stock["price"],
                priceChange: double.parse(stock["change"]),
                isMarketOpen: stock["isOpen"],
              ),
            );
          },
        ),
      ),
    );
  }
}
