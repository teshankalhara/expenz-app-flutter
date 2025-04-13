import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String btnName;
  final Color btnColor;
  const CustomBtn({super.key, required this.btnName, required this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Center(
        child: Text(
          btnName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
