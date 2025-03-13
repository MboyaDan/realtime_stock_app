import 'package:flutter/material.dart';

class TrendingStocksSection extends StatelessWidget {
  final List<Map<String, dynamic>> trendingStocks = [
    {"symbol": "AAPL", "price": "221.07", "change": "+1.5%"},
    {"symbol": "TSLA", "price": "950.20", "change": "-0.8%"},
    {"symbol": "AMZN", "price": "3,250.50", "change": "+2.3%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Trending Stocks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trendingStocks.length,
            itemBuilder: (context, index) {
              final stock = trendingStocks[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(stock["symbol"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(stock["price"]!, style: TextStyle(fontSize: 16)),
                        Text(stock["change"]!, style: TextStyle(color: stock["change"]!.contains('+') ? Colors.green : Colors.red)),
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
  }
}
