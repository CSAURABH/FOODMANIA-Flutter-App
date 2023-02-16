import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_food_ordering_app/screens/cart_screen.dart';
import 'package:my_food_ordering_app/screens/login_screen.dart';
import 'package:my_food_ordering_app/screens/profile_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  String? fname;
                  String? email;
                  Map<String, dynamic> data;
                  if (snapshot.hasData) {
                    data = snapshot.data!.data() as Map<String, dynamic>;
                    fname = data['Full-Name'];
                    email = data['Email-Id'];
                  }

                  return Container(
                    padding: const EdgeInsets.only(top: 60),
                    width: double.infinity,
                    color: Colors.orange,
                    height: 240,
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://media-exp1.licdn.com/dms/image/C5603AQEmnX59emy-Mg/profile-displayphoto-shrink_800_800/0/1606653814177?e=1663200000&v=beta&t=CA5swFJQqZC2aUQ-B55d9KWsEHW2VuIDeoGnJMmL_nw",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          fname.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          email.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              contentPadding: const EdgeInsets.only(left: 25),
              horizontalTitleGap: 30,
              onTap: () {
                Get.back();
                Get.to(() => const ProfileScreen());
              },
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              horizontalTitleGap: 30,
              contentPadding: const EdgeInsets.only(left: 25),
              onTap: () {
                Get.back();
                Get.to(() => const CartScreen());
              },
              title: const Text(
                "Cart",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "assets/icons/checklist.png",
                height: 26,
              ),
              contentPadding: const EdgeInsets.only(left: 25),
              onTap: () {
                Get.back();
                Get.to(() => const CartScreen());
              },
              horizontalTitleGap: 30,
              title: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              horizontalTitleGap: 30,
              contentPadding: EdgeInsets.only(left: 25),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "assets/icons/about.png",
                height: 26,
              ),
              horizontalTitleGap: 30,
              contentPadding: const EdgeInsets.only(left: 25),
              title: const Text(
                "About",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "assets/icons/rating.png",
                height: 26,
              ),
              contentPadding: const EdgeInsets.only(left: 25),
              horizontalTitleGap: 30,
              title: const Text(
                "Rate us on Play Store",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "assets/icons/feedback.png",
                height: 26,
              ),
              contentPadding: const EdgeInsets.only(left: 25),
              horizontalTitleGap: 30,
              title: const Text(
                "Send Feedback",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              contentPadding: const EdgeInsets.only(left: 25),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              horizontalTitleGap: 30,
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
