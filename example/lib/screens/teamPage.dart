import 'package:flutter/material.dart';
import 'package:flutter_blue_plus_example/widgets/app_large_text.dart';
import 'package:flutter_blue_plus_example/widgets/app_text.dart';
import 'package:flutter_blue_plus_example/utils/app_colors.dart'; // Assuming this is where textColor2 is defined

class teamPage extends StatelessWidget {
  const teamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      backgroundColor: Color.fromARGB(255, 227, 221, 238),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLargeText(
                text: "About Our Team",
                size: 36, // Larger font size for the title
                color: const Color.fromARGB(255, 0, 0, 0), // Custom color for the title
              ),
              SizedBox(height: 20), // Space between title and body text
              AppText(
                text: "We are the BioSense team from EPFL, a group of 14 students passionate about making a difference in kidney health. We come from various fields of study, bringing together our knowledge and skills to participate in the SensUs competition for chronic kidney disease.",
                size: 14, // Updated size for main text
                color: AppColors.textColor2, // Using textColor2 for main text
              ),
              SizedBox(height: 20), // Space between paragraphs
              AppText(
                text: "Our Journey",
                size: 24, // Subheading font size
                color: const Color.fromARGB(255, 0, 0, 0), // Custom color for subheadings
              ),
              SizedBox(height: 10), // Small space between subheading and paragraph
              AppText(
                text: "Our journey began in 2024, with a shared goal of creating accessible solutions for chronic kidney disease management. While we come from different academic backgrounds, we are united by our desire to contribute positively to the field of health technology.",
                size: 14, // Updated size for main text
                color: AppColors.textColor2, // Using textColor2 for main text
              ),
              SizedBox(height: 20), // Space between sections
              AppText(
                text: "Our Values",
                size: 24, // Subheading font size
                color: const Color.fromARGB(255, 0, 0, 0), // Custom color for subheadings
              ),
              SizedBox(height: 10), // Small space between subheading and paragraph
              AppText(
                text: "We believe in innovation, collaboration, and continuous learning. Our team is dedicated to refining our ideas and solutions to better serve the needs of those affected by chronic kidney disease.",
                size: 14, // Updated size for main text
                color: AppColors.textColor2, // Using textColor2 for main text
              ),
              SizedBox(height: 20), // Space between sections
              AppText(
                text: "Meet the Team",
                size: 24, // Subheading font size
                color: const Color.fromARGB(255, 0, 0, 0), // Custom color for subheadings
              ),
              SizedBox(height: 10), // Small space between subheading and paragraph
              
              // Image section
              Center(
                child: Image.asset(
                  "lib/images/team.jpg",
                  width: 300, // Set the width of the image
                  height: 200, // Set the height of the image
                  fit: BoxFit.cover, // Adjust the image fit
                ),
              ),
              SizedBox(height: 10), // Space between image and text
              
              AppText(
                text: "Our team is made up of students from various disciplines, including biomedical engineering, computer science, and life sciences. We collaborate closely to combine our strengths and create solutions that are both innovative and practical.",
                size: 14, // Updated size for main text
                color: AppColors.textColor2, // Using textColor2 for main text
              ),
              SizedBox(height: 20), // Final spacing at the bottom
              AppText(
                text: "Participation in SensUs",
                size: 24, // Subheading font size
                color: const Color.fromARGB(255, 0, 0, 0), // Custom color for subheadings
              ),
              SizedBox(height: 10), // Small space between subheading and paragraph
              AppText(
                text: "We are grateful to be part of the SensUs competition, where we have the opportunity to learn, grow, and contribute to the global effort to improve kidney health. This experience has been a valuable journey for all of us, and we hope to make a meaningful impact.",
                size: 14, // Updated size for main text
                color: AppColors.textColor2, // Using textColor2 for main text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
