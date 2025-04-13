import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", width: 150, fit: BoxFit.cover),
        SizedBox(height: 20),
        const Center(
          child: Text(
            "ExpenZ App",
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: kMainColor,
            ),
          ),
        ),
      ],
    );
  }
}
