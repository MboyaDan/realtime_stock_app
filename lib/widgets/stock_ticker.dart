import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/stock_controller.dart';
import '../models/stock_model.dart';

class StockTickerWidget extends StatefulWidget {
  @override
  _StockTickerWidgetState createState() => _StockTickerWidgetState();
}

class _StockTickerWidgetState extends State<StockTickerWidget> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 10),
          curve: Curves.linear,
        ).then((_) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
          _autoScroll();
        });
      }
    });
  }

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

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _autoScroll();
        });

        return Container(
          height: 40,
          color: Colors.black87,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: stockProvider.trendingStocks.length,
            itemBuilder: (context, index) {
              final Stock stock = stockProvider.trendingStocks[index];
              final isPositiveChange = stock.priceChange >= 0;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(stock.symbol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text("\$${stock.currentPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 5),
                    Text(
                      "${isPositiveChange ? '+' : ''}${stock.priceChange.toStringAsFixed(2)}%",
                      style: TextStyle(color: isPositiveChange ? Colors.green : Colors.red),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
