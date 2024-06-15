import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showForgetPasswordDialog(context);
      },
      child: Text(
        "Forgot password ?",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  void _showForgetPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Forgot Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text("Reset Password"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _resetPassword(BuildContext context) async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();

    var uri = Uri.parse('http://192.168.1.18:5000/password');

    try {
      // Send the request as a POST request with JSON data
      print('Sending reset password request to: $uri');

      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"}, // Set content type to JSON
        body: jsonEncode({'username': username, 'email': email}),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('Reset password instructions sent successfully');
        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset instructions sent to $email'),
          ),
        );
      } else {
        print('Reset password request failed');
        // Handle reset password request failure here
      }
    } catch (e) {
      print('An error occurred: $e');
      // Handle error here
    }
  }
}

