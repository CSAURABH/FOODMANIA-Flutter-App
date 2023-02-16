import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;

  const SmallButton(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(icon, size: 20, color: white),
        ),
      ),
    );
  }
}
