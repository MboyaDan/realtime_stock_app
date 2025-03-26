import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/controllers/sentiment_provider.dart';

class SentimentAnalysisSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SentimentProvider>(
      builder: (context, sentimentProvider, child) {
        if (sentimentProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        double sentimentScore = sentimentProvider.sentiment.score;
        String sentimentText = sentimentScore > 0 ? "Bullish" : "Bearish";
        Color sentimentColor = sentimentScore > 0 ? Colors.green : Colors.red;
        Icon sentimentIcon = sentimentScore > 0
            ? const Icon(Icons.trending_up, color: Colors.green)
            : const Icon(Icons.trending_down, color: Colors.red);

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                sentimentIcon,
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Market Sentiment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(sentimentText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sentimentColor)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
