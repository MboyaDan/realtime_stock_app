import 'package:flutter/material.dart';
import 'package:realtime_stock_analytics/widgets/market_overview.dart';
import 'package:realtime_stock_analytics/widgets/trending_stocks.dart';
import 'package:realtime_stock_analytics/widgets/market_news.dart';
import 'package:realtime_stock_analytics/widgets/sentiment_analysis.dart';
import 'package:realtime_stock_analytics/widgets/stock_ticker.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              MarketOverviewSection(), // Major Indices
              SizedBox(height: 20),
              TrendingStocksSection(), // Top Gainers, Losers
              SizedBox(height: 20),
              MarketNewsSection(), // Recent Market News
              SizedBox(height: 20),
              SentimentAnalysisSection(), // Bullish/Bearish Indicator
              SizedBox(height: 20),
              StockTickerWidget(), //  Real-Time Ticker
            ],
          ),
        ),
      ),
    );
  }
}
