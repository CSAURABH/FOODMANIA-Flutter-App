import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/widgets/popular_food.dart';

class FeauredFood extends StatelessWidget {
  const FeauredFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Featured Restaurants",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: ListView(
            children: [
              Column(
                children: const [PopularFood()],
              )
            ],
          ),
        ),
      ),
    );
  }
}
