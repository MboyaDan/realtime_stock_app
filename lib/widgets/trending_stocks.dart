import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/controllers/stock_controller.dart';
import 'package:realtime_stock_analytics/models/stock_model.dart';

class TrendingStocksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StockProvider>(
      builder: (context, stockProvider, child) {
        if (stockProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (stockProvider.trendingStocks.isEmpty) {
          return const Center(child: Text("No trending stocks available."));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Trending Stocks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stockProvider.trendingStocks.length,
                itemBuilder: (context, index) {
                  final Stock stock = stockProvider.trendingStocks[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              stock.symbol,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$${stock.currentPrice.toStringAsFixed(2)}", // ✅ Use currentPrice
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${stock.priceChange.toStringAsFixed(2)}%",
                              style: TextStyle(
                                color: stock.priceChange >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
