import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../screens/helpPage.dart' as HelpPageScreen;
import 'package:flutter_blue_plus_example/utils/app_colors.dart' show AppColors, textColor2;
import 'package:flutter_blue_plus_example/widgets/app_large_text.dart';
import 'chart_screen.dart';
import 'interval_page.dart';
import 'userPage.dart';
import '../screens/teamPage.dart' as teamPageScreen;
import '../screens/teamPage.dart' as teamPage;
import '../widgets/app_text.dart';
import 'detailsPage.dart';
import 'helpPage.dart';

class homePage extends StatelessWidget {  // Class names should start with an uppercase letter
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                size: 48,
              ),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text("I N T E R V A L S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntervalPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.biotech),
              title: Text("C R E A T I N I N E"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChartPage(
                      // lineColor: Colors.blue,
                      // indicatorLineColor: Colors.red,
                      // indicatorTouchedLineColor: Colors.green,
                      // indicatorSpotStrokeColor: Colors.yellow,
                      // indicatorTouchedSpotStrokeColor: Colors.orange,
                      // bottomTextColor: Colors.purple,
                      // bottomTouchedTextColor: Colors.pink,
                      // averageLineColor: Colors.brown,
                      // tooltipBgColor: Colors.grey,
                      // tooltipTextColor: Colors.white,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.diversity_3),
              title: Text("H E L P   P A G E"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPageScreen.HelpPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.diversity_1),
              title: Text("A B O U T   U S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => teamPageScreen.teamPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text("D E T A I L E D  R E S U L T S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => detailsPage(database: database)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bluetooth),
              title: Text("C O N N E C T"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => detailsPage(database: database)),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 227, 221, 238),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: Image.asset(
              "lib/images/background1.png",  
              width: 300,  
              height: 300,  
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50, left: 20, right: 20),  
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(text: "BioSense"),
                AppText(text: "Homepage", size: 30,),
                SizedBox(height: 20,),
                Container(
                  width: 250,
                  child: AppText(
                    text: "Your Kidney Health, Our Priority",
                    color: AppColors.textColor2,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
