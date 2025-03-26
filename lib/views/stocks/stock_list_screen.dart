import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/models/stock_model.dart';
import 'package:realtime_stock_analytics/widgets/stock_card.dart';
import 'package:realtime_stock_analytics/widgets/stock_details_bottomsheet.dart';
import 'package:realtime_stock_analytics/controllers/stock_controller.dart'; // ✅ Import StockProvider

class StockListScreen extends StatefulWidget {
  const StockListScreen({Key? key}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Ensure animation starts only once after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showStockDetails(BuildContext context, Stock stock) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StockDetailsBottomSheet(stock: stock),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock List"),
        backgroundColor: Colors.black,
      ),
      body: Consumer<StockProvider>(
        builder: (context, stockProvider, child) {
          if (stockProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final stockList = stockProvider.stocks;

          if (stockList.isEmpty) {
            return const Center(child: Text("No stocks available"));
          }

          return FadeTransition(
            opacity: _fadeAnimation,
            child: RefreshIndicator(
              onRefresh: () async {
                // Simulate refresh since Firestore auto-updates
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  final stock = stockList[index];
                  return GestureDetector(
                    onTap: () => _showStockDetails(context, stock),
                    child: Hero(
                      tag: "stock_${stock.symbol}",
                      child: StockCard(stock: stock),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
