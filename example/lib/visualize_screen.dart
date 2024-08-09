import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class VisualizeScreen extends StatelessWidget {
  final BluetoothCharacteristic characteristic;

  const VisualizeScreen({Key? key, required this.characteristic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualize Data"),
      ),
      body: StreamBuilder<List<int>>(
        stream: characteristic.lastValueStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          String data = String.fromCharCodes(snapshot.data!);

          return Center(
            child: Text(
              data,
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
