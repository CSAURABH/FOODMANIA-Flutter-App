import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/models/category.dart';
import 'package:my_food_ordering_app/widgets/title.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> categoriesList = [
      Category(name: "Pizza", image: "cat_1.jpg"),
      Category(name: "Burget", image: "cat_2.jpg"),
      Category(name: "Hot-dog", image: "cat_3.jpg"),
      Category(name: "Cocacola", image: "cat_4.jpg"),
      Category(name: "Donat", image: "cat_5.jpg"),
    ];
    // ignore: sized_box_for_whitespace
    return Container(
      height: 120,
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 228, 170, 178),
                      offset: Offset(1, 1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/${categoriesList[index].image}",
                  width: 50,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TitleWidget(
                text: categoriesList[index].name,
                size: 16,
                colors: black,
                weight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
