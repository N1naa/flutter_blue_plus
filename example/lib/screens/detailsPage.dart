import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'chart_screen.dart';
import 'interval_page.dart';
import 'package:fl_chart/fl_chart.dart';

class detailsPage extends StatelessWidget {
  final List<List<FlSpot>> database;

  const detailsPage({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details Page')),
      backgroundColor: Color.fromARGB(255, 227, 221, 238),
      body: ListView.builder(
        itemCount: database.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text('Interval ${index + 1}'),
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('x')),
                  DataColumn(label: Text('y')),
                ],
                rows: database[index]
                    .map((spot) => DataRow(cells: [
                          DataCell(Text(spot.x.toString())),
                          DataCell(Text(spot.y.toString())),
                        ]))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
