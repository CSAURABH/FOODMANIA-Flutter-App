import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/screens/cart_screen.dart';
import 'package:my_food_ordering_app/screens/home_screen.dart';
import 'package:my_food_ordering_app/screens/profile_screen.dart';
import 'package:my_food_ordering_app/screens/favourite_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: const [
          HomeScreen(),
          SearchScreen(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: const Color.fromARGB(255, 29, 116, 93),
        textColor: const Color.fromARGB(255, 29, 116, 93),
        inactiveIconColor: const Color.fromARGB(255, 29, 116, 93),
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.favorite_outline, title: "Favourites"),
          TabData(iconData: Icons.shopping_cart, title: "Cart"),
          TabData(iconData: Icons.account_circle_outlined, title: "Profile"),
        ],
        onTabChangedListener: (position) {
          setState(
            () {
              currentPage = position;
            },
          );
        },
      ),
    );
  }
}
