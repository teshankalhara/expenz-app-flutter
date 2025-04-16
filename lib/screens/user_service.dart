import 'package:flutter/material.dart';

class UserService {
  static Future<void> storeUserDetails(
    String username,
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (password == confirmPassword) {
      // Store user details
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password and Confirm Password do not match"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
