import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/screens/bottom_navigation_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ordered Successful",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 116, 87, 76),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Thank you!",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 94, 79, 79),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "On my way to your table",
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 94, 79, 79),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text(
                    "Go to Home",
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
