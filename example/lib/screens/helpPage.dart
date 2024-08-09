import 'package:flutter/material.dart';
import 'package:flutter_blue_plus_example/utils/app_colors.dart';
import 'package:flutter_blue_plus_example/widgets/app_large_text.dart';
import 'package:flutter_blue_plus_example/widgets/app_text.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help Page')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 227, 221, 238), // Background color
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Page 1
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset("lib/images/questions.png", width: double.infinity, fit: BoxFit.cover, height: 300),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            AppLargeText(
                              text: 'What is Chronic Kidney Disease (CKD)?',
                            ),
                            AppText(
                              text: 'Chronic Kidney Disease (CKD) is a gradual loss of kidney function over time, reducing the kidneys ability to filter waste from the blood effectively. Early stages may not show symptoms, making regular medical check-ups essential. Proper management through diet, medication, and lifestyle adjustments can help maintain kidney health and slow the progression of the disease.',
                              size: 14,
                              color: AppColors.textColor2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Page 2
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset("lib/images/food.png", width: double.infinity, fit: BoxFit.cover, height: 300),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [ 
                            AppLargeText(
                              text: 'What can I do?',
                            ),
                            AppText(
                              text: 'Adopt a healthy diet with fruits, vegetables, whole grains, and lean proteins. Limit processed foods and sodium. Exercise moderately for 30 minutes most days. Practice mindfulness with forest walks, meditation, and yoga to reduce stress. Stay connected with loved ones and support groups, and monitor your health regularly to catch any changes early.',
                              size: 14,
                              color: AppColors.textColor2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Page 3
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset("lib/images/stress.png", width: double.infinity, fit: BoxFit.cover, height: 300),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [ 
                            AppLargeText(
                              text: 'Where can I get more information?',
                            ),
                            AppText(
                              text: 'If you need help or notice unusual measurements, contact our support team at biosense@epfl.ch. For comprehensive information on kidney health, visit the American Kidney Fund at www.kidneyfund.org and the National Kidney Foundation at www.kidney.org. For more on heart health, check the American Heart Association at www.heart.org. These resources provide valuable information and support for managing kidney disease and overall health. Do not hesitate to reach out for aid :)',
                              size: 14,
                              color: AppColors.textColor2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
