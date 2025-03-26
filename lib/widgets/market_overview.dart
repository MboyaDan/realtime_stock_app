import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/controllers//market_provider.dart';

class MarketOverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (marketProvider.indices.isEmpty) {
          return const Center(child: Text("No market data available."));
        }

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Market Overview",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Column(
                  children: marketProvider.indices.map((index) {
                    return ListTile(
                      title: Text(index.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(index.value, style: const TextStyle(fontSize: 16)),
                      trailing: Text(
                        index.change,
                        style: TextStyle(color: index.change.contains('+') ? Colors.green : Colors.red),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
