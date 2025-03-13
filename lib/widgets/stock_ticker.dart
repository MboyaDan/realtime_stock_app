import 'package:flutter/material.dart';

class StockTickerWidget extends StatefulWidget {
  @override
  _StockTickerWidgetState createState() => _StockTickerWidgetState();
}

class _StockTickerWidgetState extends State<StockTickerWidget> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  final List<Map<String, String>> stocks = [
    {"symbol": "AAPL", "price": "221.07", "change": "+1.5%"},
    {"symbol": "TSLA", "price": "950.20", "change": "-0.8%"},
    {"symbol": "AMZN", "price": "3,250.50", "change": "+2.3%"},
    {"symbol": "GOOGL", "price": "2,850.75", "change": "-0.5%"},
    {"symbol": "MSFT", "price": "330.30", "change": "+1.1%"},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(Duration(seconds: 2), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 10),
        curve: Curves.linear,
      ).then((_) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        _autoScroll();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.black87,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(stock["symbol"]!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Text(stock["price"]!, style: TextStyle(color: Colors.white)),
                SizedBox(width: 5),
                Text(
                  stock["change"]!,
                  style: TextStyle(color: stock["change"]!.contains('+') ? Colors.green : Colors.red),
                ),
                SizedBox(width: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
