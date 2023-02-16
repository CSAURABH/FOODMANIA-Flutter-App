import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_food_ordering_app/widgets/favourite_dishes.dart';
import 'package:my_food_ordering_app/widgets/favourite_restaurants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          "Restaurants",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Dishes",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 553.h,
                    child: const TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: FavouriteRestaurants(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FavouriteDishes(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
