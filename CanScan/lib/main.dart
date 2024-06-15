import 'package:flutter/material.dart';
import 'package:braestcancer/login_page.dart'; // Import LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _imageYOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _imageYOffset = 100.0; // Move the image down by 100 pixels
          });
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              _imageYOffset = 0.0; // Reset the image position after 500 milliseconds
            });
          });
          Navigator.pushNamed(context, '/login');
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(0.0, _imageYOffset, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/wel.jpg'), // Replace 'background_image.jpg' with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
                child: null, // You can add content here if needed
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
