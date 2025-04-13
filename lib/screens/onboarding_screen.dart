import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/data/onboarding_data.dart';
import 'package:expenz_app/screens/onboarding/front_page.dart';
import 'package:expenz_app/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz_app/screens/user_data_screen.dart';
import 'package:expenz_app/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
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
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: (SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  )),
                ),

                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefalutPadding,
                    ),
                    child:
                        !showDetailsPage
                            ? GestureDetector(
                              onTap: () {
                                _controller.animateToPage(
                                  _controller.page!.toInt() + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: CustomBtn(
                                btnName:
                                    showDetailsPage ? "Get Started" : "Next",
                                btnColor: kMainColor,
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const UserDataScreen(),
                                  ),
                                );
                              },
                              child: CustomBtn(
                                btnName:
                                    showDetailsPage ? "Get Started" : "Next",
                                btnColor: kMainColor,
                              ),
                            ),
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
