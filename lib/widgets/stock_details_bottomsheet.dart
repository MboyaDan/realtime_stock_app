import 'package:flutter/material.dart';
import 'package:realtime_stock_analytics/models/stock_model.dart';
import 'package:realtime_stock_analytics/widgets/stock_chart.dart';

class StockDetailsBottomSheet extends StatelessWidget {
  final Stock stock;

  const StockDetailsBottomSheet({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            stock.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Symbol: ${stock.symbol}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price: \$${stock.currentPrice.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${stock.priceChange >= 0 ? '+' : ''}${stock.priceChange.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: stock.priceChange >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Stock Price Trend",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          StockChart(
            stockPrices: stock.historicalPrices,
            timestamps: List.generate(
              stock.historicalPrices.length,
                  (index) => DateTime.now().subtract(Duration(minutes: stock.historicalPrices.length - index)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
