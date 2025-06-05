import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/exercise_record.dart';

class AnalysisScreen extends StatelessWidget {
  final List<ExerciseRecord> records;

  const AnalysisScreen({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('运动分析'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('运动统计图表', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: records
                          .map((record) => FlSpot(
                              record.startTime.millisecondsSinceEpoch
                                  .toDouble(),
                              record.count.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
