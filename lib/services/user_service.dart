import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<void> storeUserDetails({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    if (password == confirmPassword) {
      // Store user details
      // users psswrd and cnfirm psswrd are same then store usr data

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //store usr data
        await prefs.setString("username", username);
        await prefs.setString("email", email);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User data stored successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (err) {
        err.toString();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password and Confirm Password do not match"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  //check weather the username is saved in the shared preferences
  static Future<bool> checkUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    return username != null;
  }
}
