import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/widgets/title.dart';

class FavouriteScreenProducts extends StatelessWidget {
  const FavouriteScreenProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 224, 224, 224),
              offset: Offset(-2, -1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.asset(
                  "assets/images/food.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TitleWidget(
                          text: "Chapati",
                          size: 18,
                          colors: black,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  offset: Offset(1, 1),
                                  blurRadius: 4),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: <Widget>[
                        const TitleWidget(
                          text: "form:",
                          size: 14,
                          colors: Color.fromARGB(255, 137, 134, 134),
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: const TitleWidget(
                            text: "Burger King Restaurant",
                            size: 14,
                            colors: Colors.red,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TitleWidget(
                              text: "4.2",
                              size: 14,
                              colors: Color.fromARGB(255, 94, 91, 91),
                              weight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: grey,
                            size: 16,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: TitleWidget(
                          text: "5.0",
                          size: 16,
                          colors: black,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
