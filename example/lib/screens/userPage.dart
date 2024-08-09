import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_example/screens/homePage.dart';
import 'chart_screen.dart';
import 'interval_page.dart';

class userPage extends StatelessWidget {
  const userPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Page')),
    );
  }
}
