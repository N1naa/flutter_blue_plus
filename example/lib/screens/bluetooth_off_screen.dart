// open ios/Runner.xcworkspace
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_example/screens/homePage.dart';
import 'chart_screen.dart';
import 'interval_page.dart';
import 'homePage.dart';
class Snackbar {
  static final GlobalKey<ScaffoldMessengerState> snackBarKeyA = GlobalKey<ScaffoldMessengerState>();

  static void show(GlobalKey<ScaffoldMessengerState> key, String message, {bool success = true}) {
    key.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }
}

// Placeholder for the ABC class
class ABC {
  static final a = Snackbar.snackBarKeyA;
  static final b = Snackbar.snackBarKeyA;
}

// Placeholder for the prettyException function
String prettyException(String message, dynamic exception) {
  return '$message ${exception.toString()}';
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.adapterState}) : super(key: key);

  final BluetoothAdapterState? adapterState;

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
  }

  Widget buildTitle(BuildContext context) {
    String? state = adapterState?.toString().split(".").last;
    return Text(
      'Bluetooth Adapter is ${state != null ? state : 'not available'}',
      style: Theme.of(context).primaryTextTheme.titleSmall?.copyWith(color: Colors.white),
    );
  }

  Future onTestPressed() async {
    try {
      Snackbar.show(ABC.a, 'Stopping Scan...', success: true);
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Test Button Error:", e), success: false);
    }
  }

  Widget buildTestButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTestPressed,
    );
  }

  Widget buildTurnOnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('TURN ON'),
        onPressed: () async {
          try {
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
            }
          } catch (e) {
            Snackbar.show(ABC.a, prettyException("Error Turning On:", e), success: false);
          }
        },
      ),
    );
  }

    Widget buildHistoryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('Creatinine History Graph'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChartPage(
                // lineColor: Colors.red,
                // indicatorLineColor: Colors.yellow.withOpacity(0.2),
                // indicatorTouchedLineColor: Colors.yellow,
                // indicatorSpotStrokeColor: Colors.yellow.withOpacity(0.5),
                // indicatorTouchedSpotStrokeColor: Colors.yellow,
                // bottomTextColor: Colors.yellow.withOpacity(0.2),
                // bottomTouchedTextColor: Colors.yellow,
                // averageLineColor: Colors.green.withOpacity(0.8),
                // tooltipBgColor: Colors.green,
                // tooltipTextColor: Colors.black,
              ),
            ), 
          );
        },
      ),
    );
  }

  Widget buildIntervalButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('Homepage'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              //builder: (context) => IntervalPage( 
              builder: (context) => homePage(
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(context),
              buildTitle(context),
              if (Platform.isAndroid) buildTurnOnButton(context),
              //buildHistoryButton(context),
              buildIntervalButton(context), 
              //buildInferenceButton(context),
            ],
          ),
        ),
        //floatingActionButton: buildTestButton(context),
      ),
    );
  }
}
