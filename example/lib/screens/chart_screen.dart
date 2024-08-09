import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus_example/utils/app_colors.dart';
import 'package:flutter_blue_plus_example/widgets/app_text.dart';
import '../utils/chart3.dart'; 
import '../utils/chart2.dart' as Chart2; 
import '../widgets/app_text.dart';
import '../utils/chart2.dart'; 

// Points saved in this database --> plotting done in function of length of it
List<List<FlSpot>> database = [
  // Interval 1
  [
    FlSpot(0, 3),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
  ],
  // Interval 2
  [
    FlSpot(0, 2.5),
    FlSpot(2.6, 3.2),
    FlSpot(4.9, 4.5),
    FlSpot(6.8, 2.1),
    FlSpot(8, 3.5),
    FlSpot(9.5, 2.8),
    FlSpot(11, 3.7),
  ],
  // Interval 3
  [
    FlSpot(0, 1),
    FlSpot(2.6, 4),
    FlSpot(4.9, 2),
    FlSpot(6.8, 1),
    FlSpot(8, 1),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
  ],
];

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<double> averages = [];

  @override
  void initState() {
    super.initState();
    averages = List.filled(database.length, 0.0);
  }

  void updateAverage(int index, double average) {
    Future.delayed(Duration.zero, () {
      setState(() {
        averages[index] = average;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creatinine History'),
      ),
      backgroundColor: Color.fromARGB(255, 227, 221, 238),
      body: ListView.builder(
        itemCount: database.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              AppText(
                text: "Interval ${index + 1}",
                color: Color.fromARGB(255, 15, 15, 15),
                size: 14,
              ),
              SizedBox(
                height: 200, 
                child: LineChartSample2(
                  database: [database[index]],
                  onAverageCalculated: (average) => updateAverage(index, average),
                ),
              ),
              AppText(
                text: "Conc: ${averages[index]} µM/L",
                size: 14,
              ),
              SizedBox(height: 20), 
            ],
          );
        },
      ),
    );
  }
}

