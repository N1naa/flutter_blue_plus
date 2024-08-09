import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../utils/DatabaseHelper.dart';

class IntervalPage extends StatefulWidget {
  @override
  _IntervalPageState createState() => _IntervalPageState();
}

class _IntervalPageState extends State<IntervalPage> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  Random _random = Random();
  List<int> _data = [];
  int _currentSampleId = 1;

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _data.clear(); // Clear previous data when starting a new sample
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() async {
        _seconds++;
        int newValue = _random.nextInt(100); // Simulate incoming data
        _data.add(newValue);
        await DatabaseHelper.instance.insertData(_currentSampleId, newValue);
        print('Inserted data: Sample ID $_currentSampleId, Value $newValue');
      });
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;

    setState(() {
      _isRunning = false;
      _currentSampleId++;
      _seconds = 0; // Reset the timer for the next sample
    });

    _timer?.cancel();
    print('Stopped timer. Next sample ID: $_currentSampleId');
  }

  @override
  void dispose() {
    _timer?.cancel();
    DatabaseHelper.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intervals'),
      ),
      backgroundColor: Color.fromARGB(255, 227, 221, 238),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                ),
              ],
            ),
          ),
          Text(
            'Timer: $_seconds seconds',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DatabaseHelper.instance.fetchData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data ?? [];
                Map<int, List<int>> samples = {};
                for (var row in data) {
                  int sampleId = row['sample_id'] ?? 0;
                  int value = row['value'] ?? 0;
                  if (!samples.containsKey(sampleId)) {
                    samples[sampleId] = [];
                  }
                  samples[sampleId]!.add(value);
                }

                if (samples.isEmpty) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }

                return ListView(
                  children: samples.entries.map((entry) {
                    return ExpansionTile(
                      title: Text(
                        'Sample ${entry.key}',
                        style: TextStyle(color: Colors.white),
                      ),
                      children: entry.value.map((value) {
                        return ListTile(
                          title: Text(
                            'Value: $value',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
