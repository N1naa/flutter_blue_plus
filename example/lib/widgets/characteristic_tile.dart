import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../utils/database_helper.dart';  // Added import for DatabaseHelper
import "../utils/snackbar.dart";
import "descriptor_tile.dart";
class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final String additionalInfo;

  const CharacteristicTile({Key? key, required this.characteristic, required this.descriptorTiles, required this.additionalInfo}) : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  List<int> _value = [];
  String _decodedValue = '';
  List<String> _readValues = []; // List to store read values

  late StreamSubscription<List<int>> _lastValueSubscription;

  @override
  void initState() {
    super.initState();
    _lastValueSubscription = widget.characteristic.lastValueStream.listen((value) async {
      _value = value;
      _decodedValue = _decodeValue(value);
      await DatabaseHelper().insertSinusData(_decodedValue); // Save new value to the database
      _readValues = await DatabaseHelper().getSinusData(); // Retrieve data from the database
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    super.dispose();
  }

  BluetoothCharacteristic get c => widget.characteristic;

  List<int> _getRandomBytes() {
    final math = Random();
    return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
  }

  Future<void> _fetchData() async {
    _readValues = await DatabaseHelper().getSinusData();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _clearData() async {
    await DatabaseHelper().clearSinusData();
    _fetchData();
  }

  Future onReadPressed() async {
    try {
      List<int> value = await c.read();
      _decodedValue = _decodeValue(value);
      await DatabaseHelper().insertSinusData(_decodedValue); // Save new value to the database
      _readValues = await DatabaseHelper().getSinusData(); // Retrieve data from the database
      if (mounted) {
        setState(() {});
      }
      Snackbar.show(ABC.c, "Read: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
    }
  }

  Future onWritePressed() async {
    try {
      await c.write(_getRandomBytes(), withoutResponse: c.properties.writeWithoutResponse);
      Snackbar.show(ABC.c, "Write: Success", success: true);
      if (c.properties.read) {
        List<int> value = await c.read();
        _decodedValue = _decodeValue(value);
        await DatabaseHelper().insertSinusData(_decodedValue); // Save new value to the database
        _readValues = await DatabaseHelper().getSinusData(); // Retrieve data from the database
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    }
  }

  Future onSubscribePressed() async {
    try {
      String op = c.isNotifying == false ? "Subscribe" : "Unsubscribe";
      await c.setNotifyValue(c.isNotifying == false);
      Snackbar.show(ABC.c, "$op : Success", success: true);
      if (c.properties.read) {
        List<int> value = await c.read();
        _decodedValue = _decodeValue(value);
        await DatabaseHelper().insertSinusData(_decodedValue); // Save new value to the database
        _readValues = await DatabaseHelper().getSinusData(); // Retrieve data from the database
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Subscribe Error:", e), success: false);
    }
  }

  // Helper method to decode the value
  String _decodeValue(List<int> value) {
    try {
      return String.fromCharCodes(value);
    } catch (e) {
      return value.toString(); // Fallback to displaying the byte array
    }
  }

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${widget.characteristic.uuid.str.toUpperCase()}';
    return Text(uuid, style: TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    String data = _decodedValue.isNotEmpty ? _decodedValue : _value.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data, style: TextStyle(fontSize: 13, color: Colors.grey)),
        if (widget.additionalInfo.isNotEmpty)
          Text(widget.additionalInfo, style: TextStyle(fontSize: 13, color: Colors.blue)),
      ],
    );
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
      child: Text("Read"),
      onPressed: () async {
        await onReadPressed();
        if (mounted) {
          setState(() {});
        }
      }
    );
  }

  Widget buildWriteButton(BuildContext context) {
    bool withoutResp = widget.characteristic.properties.writeWithoutResponse;
    return TextButton(
      child: Text(withoutResp ? "WriteNoResp" : "Write"),
      onPressed: () async {
        await onWritePressed();
        if (mounted) {
          setState(() {});
        }
      }
    );
  }

  Widget buildSubscribeButton(BuildContext context) {
    bool isNotifying = widget.characteristic.isNotifying;
    return TextButton(
      child: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
      onPressed: () async {
        await onSubscribePressed();
        if (mounted) {
          setState(() {});
        }
      }
    );
  }

  Widget buildButtonRow(BuildContext context) {
    bool read = widget.characteristic.properties.read;
    bool write = widget.characteristic.properties.write;
    bool notify = widget.characteristic.properties.notify;
    bool indicate = widget.characteristic.properties.indicate;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (read) buildReadButton(context),
        if (write) buildWriteButton(context),
        if (notify || indicate) buildSubscribeButton(context),
      ],
    );
  }

  Widget buildReadValuesList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _readValues.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_readValues[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Characteristic'),
                buildUuid(context),
                buildValue(context),
              ],
            ),
            subtitle: buildButtonRow(context),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          children: [
            ...widget.descriptorTiles,
            buildReadValuesList(context), // Display the list of read values
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchData,
              child: Text("Refresh Data"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _clearData,
              child: Text("Clear Data"),
            ),
          ],
        ),
      ],
    );
  }
}
