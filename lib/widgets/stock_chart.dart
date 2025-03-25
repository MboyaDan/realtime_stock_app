import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockChart extends StatelessWidget {
  final List<double> stockPrices;
  final List<DateTime> timestamps;

  const StockChart({Key? key, required this.stockPrices, required this.timestamps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: isDarkMode ? Colors.grey.withAlpha(77) : Colors.grey.withAlpha(51), // Replacing withAlpha()
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) => Text(
                  "\$${value.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= timestamps.length) return const SizedBox();
                  final formattedTime = DateFormat('HH:mm:ss').format(timestamps[index]);
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      formattedTime,
                      style: TextStyle(fontSize: 12, color: isDarkMode ? Colors.white70 : Colors.black54),
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.withAlpha(128), width: 1), // Fixed withAlpha()
          ),
          lineBarsData: [
            LineChartBarData(
              spots: stockPrices
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [Colors.orangeAccent, Colors.deepOrange]
                    : [Colors.blueAccent, Colors.cyan],
              ),
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [Colors.deepOrange.withAlpha(51), Colors.orange.withAlpha(13)] // Replacing withAlpha()
                      : [Colors.blue.withAlpha(77), Colors.cyan.withAlpha(26)], // Replacing withAlpha()
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(8),
              tooltipRoundedRadius: 8,
              tooltipBorder: BorderSide(color: Colors.white.withAlpha(128)), // New way to define border
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  int index = spot.x.toInt();
                  if (index < 0 || index >= timestamps.length) return null;
                  return LineTooltipItem(
                    "${DateFormat('HH:mm:ss').format(timestamps[index])} - \$${spot.y.toStringAsFixed(2)}",
                    TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).whereType<LineTooltipItem>().toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
