import 'package:english_copy/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const routeName = 'Splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Size queryData = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/update/splash.png"),
            SizedBox(
              height: queryData.height * 0.04,
            ),
            Text(
              'Welcome To Avinya',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: queryData.height * 0.02,
            ),
            Text(
              'Empower your mind and discover new horizons with our innovative learning platform. Discover the future of learning and unleash your potential with us',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: queryData.height * 0.1,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F75FA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: SizedBox(
                width: queryData.width,
                height: queryData.height * 0.08,
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
