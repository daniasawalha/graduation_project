import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue, // Customize primary color for iOS
        hintColor: Colors.green, // Customize accent color for iOS
        scaffoldBackgroundColor: Colors.white, // Set scaffold background color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[300], // Set app bar background color
          elevation: 1, // Remove app bar shadow
          iconTheme: IconThemeData(
            color: Colors.black, // Set app bar icon color
          ), toolbarTextStyle: TextTheme(
          headline6: TextStyle(
            color: Colors.black, // Set app bar text color
            fontSize: 20, // Set app bar text size
            fontWeight: FontWeight.bold, // Set app bar text weight
          ),
        ).bodyText2, titleTextStyle: TextTheme(
          headline6: TextStyle(
            color: Colors.white, // Set app bar text color
            fontSize: 20, // Set app bar text size
            fontWeight: FontWeight.bold, // Set app bar text weight
          ),
        ).headline6,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 16, // Set body text size
            color: Colors.black87, // Set body text color
          ),
          button: TextStyle(
            fontSize: 16, // Set button text size
            fontWeight: FontWeight.bold, // Set button text weight
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Set elevated button background color
            onPrimary: Colors.white, // Set elevated button text color
            padding: EdgeInsets.symmetric(vertical: 14), // Adjust button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Adjust button border radius
            ),
          ),
        ),
      ),
      home: HomePage(idDoctor: '',),
    );
  }
}