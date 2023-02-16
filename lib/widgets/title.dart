import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color colors;
  final FontWeight weight;
  const TitleWidget(
      {Key? key,
      required this.text,
      required this.size,
      required this.colors,
      required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: colors,
        fontWeight: weight,
      ),
    );
  }
}
