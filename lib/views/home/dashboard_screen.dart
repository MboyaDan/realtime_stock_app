import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/widgets/market_overview.dart';
import 'package:realtime_stock_analytics/widgets/trending_stocks.dart';
import 'package:realtime_stock_analytics/widgets/market_news.dart';
import 'package:realtime_stock_analytics/widgets/sentiment_analysis.dart';
import 'package:realtime_stock_analytics/widgets/stock_ticker.dart';
import 'package:realtime_stock_analytics/controllers/stock_controller.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  MarketOverviewSection(), // Major Indices
                  const SizedBox(height: 20),
                  TrendingStocksSection(), // Top Gainers, Losers
                  const SizedBox(height: 20),
                  MarketNewsSection(), // Recent Market News
                  const SizedBox(height: 20),
                  SentimentAnalysisSection(), // Bullish/Bearish Indicator
                  const SizedBox(height: 20),
                ]),
              ),
            ),
            // Stock Ticker (Wrap in SizedBox to avoid layout issues in Slivers)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40, // Fixed height to prevent layout issues
                child: Consumer<StockProvider>(
                  builder: (context, stockProvider, child) {
                    return stockProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : StockTickerWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
