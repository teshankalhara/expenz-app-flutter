import 'package:expenz_app/models/onboarding_model.dart';

class OnbardingData {
  static final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      title: "Gain total control of your money",
      imagePath: "assets/images/onboard_1.png",
      description: "Become your own money manager and make every cent count",
    ),
    OnboardingModel(
      title: "Know where your money goes",
      imagePath: "assets/images/onboard_2.png",
      description:
          "Track your transaction easily,with categories and financial report ",
    ),
    OnboardingModel(
      title: "Planning ahead",
      imagePath: "assets/images/onboard_3.png",
      description: "Setup your budget for each category so you in control",
    ),
  ];
}
