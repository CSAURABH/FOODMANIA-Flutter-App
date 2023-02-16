import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/screens/drawer.dart';
import 'package:my_food_ordering_app/screens/featured_food.dart';
import 'package:my_food_ordering_app/widgets/featured_products.dart';
import 'package:my_food_ordering_app/widgets/popular_food.dart';
import 'package:my_food_ordering_app/widgets/title.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("FOODMANIA"),
        centerTitle: true,
      ),
      drawer: const NavigationDrawerWidget(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey,
                          offset: const Offset(1, 1),
                          blurRadius: 4.r,
                        ),
                      ],
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintStyle: TextStyle(fontSize: 20),
                          hintText: "Find food or Restaurant",
                        ),
                      ),
                      trailing: Icon(Icons.filter_list),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TitleWidget(
                    text: "Eat what makes you happy",
                    size: 18.sp,
                    colors: const Color.fromARGB(255, 73, 72, 72),
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food1.png",
                            text: "Pizza",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food2.png",
                            text: "Burger",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food3.png",
                            text: "Sandwich",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food4.png",
                            text: "Rolls",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food5.png",
                            text: "Home Style",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food6.png",
                            text: "Fries",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food7.png",
                            text: "Thali",
                          ),
                          FeaturedImage(
                            imageTap: () => Get.to(() => const FeauredFood()),
                            image: "assets/images/food8.png",
                            text: "Samosa",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TitleWidget(
                    text: "Popular Restaurants",
                    size: 18.sp,
                    colors: const Color.fromARGB(255, 73, 72, 72),
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const PopularFood(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
