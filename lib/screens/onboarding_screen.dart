import 'package:expenz_app/data/onboarding_data.dart';
import 'package:expenz_app/screens/onboarding/front_page.dart';
import 'package:expenz_app/screens/onboarding/shared_onboarding_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[0].title,
                      imagePath: OnbardingData.onboardingList[0].imagePath,
                      description: OnbardingData.onboardingList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[1].title,
                      imagePath: OnbardingData.onboardingList[1].imagePath,
                      description: OnbardingData.onboardingList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnbardingData.onboardingList[2].title,
                      imagePath: OnbardingData.onboardingList[2].imagePath,
                      description: OnbardingData.onboardingList[2].description,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
