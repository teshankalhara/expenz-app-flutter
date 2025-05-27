import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/screens/onboarding_screen.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_services.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/profile_cart.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";

  @override
  void initState() {
    UserService.getUserDeta().then((value) {
      if (value["username"] != null && value["email"] != null) {
        setState(() {
          username = value["username"]!;
          email = value["email"]!;
        });
      }
    });
    super.initState();
  }

  //scaffold for logout
  void _showBottomSheet(BuildContext context) {
    showBottomSheet(
      backgroundColor: kLightGrey,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kMainColor),
                    ),
                    onPressed: () async {
                      await UserService.clearUserData();
                      if (context.mounted) {
                        await ExpenseService().deleteAllExpenses(context);
                        await IncomeServices().deleteAllIncomes(context);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text("Yes", style: TextStyle(color: kWhite)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kRed),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text("No", style: TextStyle(color: kWhite)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              //bg column
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kMainColor,
                        border: Border.all(color: kMainColor, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/user.jpg',
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          "Welcome $username",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: kGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kLightGrey,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: kMainColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                const ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kGreen,
                ),
                GestureDetector(
                  onTap: () => _showBottomSheet(context),
                  child: const ProfileCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
