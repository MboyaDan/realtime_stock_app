import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/providers/theme_provider.dart';
import 'package:realtime_stock_analytics/services/stock_service.dart';
import 'package:realtime_stock_analytics/widgets/stock_chart.dart';

class StockDetailsScreen extends StatefulWidget {
  final String stockName;
  final String stockSymbol;

  const StockDetailsScreen({Key? key, required this.stockName, required this.stockSymbol}) : super(key: key);

  @override
  _StockDetailsScreenState createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> with SingleTickerProviderStateMixin {
  List<double> stockPrices = [];
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    fetchStockData();
  }

  void fetchStockData() async {
    try {
      List<double> prices = await StockService.fetchStockPrices(widget.stockSymbol);
      setState(() {
        stockPrices = prices;
        isLoading = false;
      });

      _controller.forward(); // Trigger fade-in animation after data loads
    } catch (e) {
      print("Error fetching stock data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getPriceChangeColor() {
    if (stockPrices.length < 2) return Colors.white;
    return stockPrices.last >= stockPrices.first ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.stockName} (${widget.stockSymbol})"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "stock_${widget.stockSymbol}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.stockName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Stock Price Trend",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              StockChart(stockPrices: stockPrices),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Price: \$${stockPrices.isNotEmpty ? stockPrices.last.toStringAsFixed(2) : 'N/A'}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (stockPrices.length >= 2)
                    Text(
                      "${(stockPrices.last - stockPrices.first).toStringAsFixed(2)}%",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: getPriceChangeColor()),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
