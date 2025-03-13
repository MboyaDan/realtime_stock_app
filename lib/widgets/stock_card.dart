import 'package:flutter/material.dart';

class StockCard extends StatefulWidget {
  final String stockName;
  final String stockSymbol;
  final double currentPrice;
  final double priceChange;
  final bool isMarketOpen;

  const StockCard({
    Key? key,
    required this.stockName,
    required this.stockSymbol,
    required this.currentPrice,
    required this.priceChange,
    required this.isMarketOpen,
  }) : super(key: key);

  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _priceColorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _priceColorAnimation = ColorTween(
      begin: Colors.white,
      end: widget.priceChange >= 0 ? Colors.green : Colors.red,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(StockCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPrice != widget.currentPrice) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.stockName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.stockSymbol,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedBuilder(
                  animation: _priceColorAnimation,
                  builder: (context, child) {
                    return Text(
                      "\$${widget.currentPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _priceColorAnimation.value),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  widget.priceChange >= 0
                      ? "+${widget.priceChange.toStringAsFixed(2)}%"
                      : "${widget.priceChange.toStringAsFixed(2)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.priceChange >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
