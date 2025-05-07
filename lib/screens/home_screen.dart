import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";

  @override
  void initState() {
    //get the username form the shared preferences
    UserService.getUserDeta().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //main column
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: kMainColor.withOpacity(0.20),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
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
                        Text(
                          "Welcome $username",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: kMainColor,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
