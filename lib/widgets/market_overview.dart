import 'package:flutter/material.dart';

class MarketOverviewSection extends StatelessWidget {
  final List<Map<String, String>> indices = [
    {"name": "S&P 500", "value": "4,500", "change": "+0.5%"},
    {"name": "NASDAQ", "value": "14,200", "change": "-0.3%"},
    {"name": "Dow Jones", "value": "35,600", "change": "+1.2%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Market Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: indices.map((index) {
                return ListTile(
                  title: Text(index["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(index["value"]!, style: TextStyle(fontSize: 16)),
                  trailing: Text(index["change"]!, style: TextStyle(color: index["change"]!.contains('+') ? Colors.green : Colors.red)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
