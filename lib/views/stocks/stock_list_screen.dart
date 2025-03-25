import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_stock_analytics/models/stock_model.dart';
import 'package:realtime_stock_analytics/services/stock_service.dart';
import 'package:realtime_stock_analytics/widgets/stock_card.dart';
import 'package:realtime_stock_analytics/widgets/stock_details_bottomsheet.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({Key? key}) : super(key: key);

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final FirestoreService _firestoreService = FirestoreService(); // Firestore instance

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to show the bottom sheet
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
      body: StreamBuilder<List<Stock>>(
        stream: _firestoreService.getRealTimeStockPrices(), // Listening to Firestore updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading stocks", style: TextStyle(color: Colors.red)));
          }

          final stockList = snapshot.data ?? [];

          if (stockList.isEmpty) {
            return const Center(child: Text("No stocks available"));
          }

          _controller.forward(); // Trigger animation when data loads

          return FadeTransition(
            opacity: _fadeAnimation,
            child: RefreshIndicator(
              onRefresh: () async {}, // No need to refresh manually; Firestore updates in real-time
              child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: (context, index) {
                  final stock = stockList[index];
                  return GestureDetector(
                    onTap: () => _showStockDetails(context, stock), // Open bottom sheet on tap
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
