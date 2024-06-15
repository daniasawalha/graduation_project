import 'package:braestcancer/home_page.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'forget_password.dart'; // Import the ForgetPassword widget 'dart:convert';
import 'package:flutter/material.dart';

import 'image_list_page.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String username = nameController.text.trim();
    String password = passwordController.text.trim();
    String idDoctor = await _getDoctorId();
    var uri = Uri.parse('http://192.168.1.18:5000/loginGet');

    try {
      // Send the request as a POST request with JSON data
      print('Sending login request to: $uri');

      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json","idDoctor": idDoctor}, // Set content type to JSON
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data == "Login failed.") {
          print('Login failed.');

        }
        else {
          print('Login successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(idDoctor: data)),
          );

          // Handle login failure here
        }
      }
      else{
        print(response.statusCode);
      }
    } catch (e) {
      print('An error occurred: $e');
      // Handle error here
    }
  }

  // Function to get the doctor's ID
  Future<String> _getDoctorId() async {
    // Implement your logic to retrieve the doctor's ID here
    // This could involve making another HTTP request or accessing local storage
    // For example:
    // var idDoctor = await someApiFunctionToGetDoctorId();
    var idDoctor = "YOUR_DOCTOR_ID"; // Replace with your actual doctor ID retrieval logic
    return idDoctor;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            // This function will be called when the login section is tapped.
            print('Login tapped!');
            // You can replace the print statement with your login logic.
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pp.jpg'), // Change the path to your image
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Set color to white with opacity

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200] ??
                                          Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[200] ??
                                          Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        ForgetPassword(), // Include ForgetPassword widget here
                        SizedBox(height: 40),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 253, 212, 226),), // Change color here
                            ),
                            child: const Text('Login', style: TextStyle(
    color: Color.fromARGB(255, 0, 0, 0), // Change 'Colors.blue' to whatever color you prefer
  ),),
                          
                            onPressed: () {
                              // Handle login button press
                              _login(context);
                            },
                          ),
                        ),
                      ],
                    ),
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
