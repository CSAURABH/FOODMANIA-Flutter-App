import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/models/restaurants.dart';
import 'package:my_food_ordering_app/widgets/restaurants_products.dart';
import 'package:my_food_ordering_app/widgets/small_floating_button.dart';
import 'package:my_food_ordering_app/widgets/title.dart';

class GetProductByRestaurant extends StatefulWidget {
  final int index;
  final Restaurants restaurants;
  const GetProductByRestaurant({
    Key? key,
    required this.index,
    required this.restaurants,
  }) : super(key: key);

  @override
  State<GetProductByRestaurant> createState() => _GetProductByRestaurantState();
}

class _GetProductByRestaurantState extends State<GetProductByRestaurant> {
  List<Restaurants>? restaurants;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: <Widget>[
                // restaurant image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.restaurants.image,
                    height: 200,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),

                // fading black
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    ),
                  ),
                ),

                //restaurant name
                Positioned.fill(
                  bottom: 75,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TitleWidget(
                      text: widget.restaurants.name,
                      size: 26,
                      colors: white,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),

                // average price
                Positioned.fill(
                  bottom: 50,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TitleWidget(
                      text: widget.restaurants.foods,
                      size: 18,
                      colors: white,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),

                // rating widget
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(widget.restaurants.ratings.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // close button
                Positioned.fill(
                  top: 5,
                  left: 10,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: black.withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //like button
                Positioned.fill(
                    top: 5,
                    right: 10,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {},
                          child: const SmallButton(Icons.favorite),
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                RestaurantProducts(
                  restaurants: widget.restaurants,
                  index: widget.index,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
