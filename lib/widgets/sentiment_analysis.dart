import 'package:flutter/material.dart';

class SentimentAnalysisSection extends StatelessWidget {
  final double sentimentScore = 0.7; // Dummy sentiment score (-1 to 1)

  @override
  Widget build(BuildContext context) {
    String sentimentText = sentimentScore > 0 ? "Bullish" : "Bearish";
    Color sentimentColor = sentimentScore > 0 ? Colors.green : Colors.red;
    Icon sentimentIcon = sentimentScore > 0 ? Icon(Icons.trending_up, color: Colors.green) : Icon(Icons.trending_down, color: Colors.red);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            sentimentIcon,
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Market Sentiment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(sentimentText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sentimentColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
