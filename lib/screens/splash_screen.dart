import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background_intro.jpg",
            ),
            Positioned(
              top: 230.h,
              left: 50.w,
              right: 50.w,
              child: Image.asset(
                "assets/images/logo.png",
                height: 250.h,
                width: 250.w,
              ),
            ),
            Positioned(
              top: 100.h,
              left: 50.w,
              right: 50.w,
              child: Text(
                "FoodMania",
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left: 50.w,
              right: 50.w,
              bottom: 40.h,
              child: GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
