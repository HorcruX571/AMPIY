import 'package:ampiy/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MarketVariationGraph extends StatelessWidget {
  final List<Map<String, dynamic>> marketData;
  final Map<String, Crypto> data; // Keeping this for potential future use

  MarketVariationGraph({
    required this.marketData,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // Extract gains and losses from the market data
    List<BarChartGroupData> barGroups = marketData.map((data) {
      final double change =
          data['change'] != null ? data['change'].toDouble() : 0.0;
      final bool isGain = change >= 0;

      return BarChartGroupData(
        x: data['index'] ?? 0, // Default to 0 if 'index' is null
        barRods: [
          BarChartRodData(
            toY: change.abs(),
            color: isGain ? Colors.green : Colors.red,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Variation Spectrum',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: marketData.fold<double>(0, (prev, data) {
                  final double change =
                      data['change'] != null ? data['change'].toDouble() : 0.0;
                  return change.abs() > prev ? change.abs() : prev;
                }),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: barGroups,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
