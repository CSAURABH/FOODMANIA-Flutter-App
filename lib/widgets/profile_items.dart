import 'package:flutter/material.dart';

class ProfileItems extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color bcolor;
  const ProfileItems(
      {Key? key, required this.text, required this.icon, required this.bcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 214, 217, 216),
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 81,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: bcolor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
