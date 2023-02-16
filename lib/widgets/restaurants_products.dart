import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/models/restaurants.dart';
import 'package:my_food_ordering_app/screens/details_screen.dart';
import 'package:my_food_ordering_app/widgets/title.dart';

class RestaurantProducts extends StatefulWidget {
  final int index;
  final Restaurants restaurants;
  const RestaurantProducts({
    Key? key,
    required this.restaurants,
    required this.index,
  }) : super(key: key);

  @override
  State<RestaurantProducts> createState() => RestaurantProductsState();
}

class RestaurantProductsState extends State<RestaurantProducts> {
// ignore: unused_field
  final List _dishes = [];

  List<Map<String, dynamic>> list = [];

  fetchRestaurantDishes() async {
    // ignore: unused_local_variable
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("restaurants-items")
        .where("id", isEqualTo: widget.index)
        .get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _dishes.add({
          "image": qn.docs[i]["image"],
          "name": qn.docs[i]["name"],
          "price": qn.docs[i]["price"],
        });
      }
    });
  }

  bool isMoreData = true;

  // Pagination in flutter
  DocumentSnapshot? lastData;
  pagination() async {
    if (isMoreData) {
      final collectionreferece =
          FirebaseFirestore.instance.collection('restaurants-items');

      // ignore: unused_local_variable
      late QuerySnapshot querySnapshot;
      if (lastData != null) {
        querySnapshot = await collectionreferece
            .limit(5)
            .where("id", isEqualTo: widget.index)
            .get();
      } else {
        querySnapshot = await collectionreferece
            .limit(5)
            .startAfterDocument(lastData!)
            .get();
      }

      lastData = querySnapshot.docs.last;

      // list.addAll(querySnapshot.docs.map((e) => e.data()));

      if (querySnapshot.docs.length < 5) {
        isMoreData = false;
      }
    } else {
      // ignore: avoid_print
      print('No more Data');
    }
  }

  Future addToFavouriteDishes(int index) {
    var currentUser = FirebaseAuth.instance.currentUser;
    // ignore: no_leading_underscores_for_local_identifiers
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-favourite-dishes");

    return _collectionRef
        .doc(currentUser!.email)
        .collection("dishes")
        .doc()
        .set({
      "name": _dishes[index]["name"],
      "price": _dishes[index]["price"],
      "image": _dishes[index]["image"],
      "restaurant-name": widget.restaurants.name,
    }).then(
      (value) => Fluttertoast.showToast(msg: "Added to Favourite"),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRestaurantDishes();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 540,
      child: ListView.builder(
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    name: _dishes[index]["name"],
                    image: _dishes[index]["image"],
                    price: _dishes[index]["price"],
                  ),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 224, 224, 224),
                        offset: Offset(-2, -1),
                        blurRadius: 5),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 140,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: Image.network(
                          _dishes[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TitleWidget(
                                  text: _dishes[index]["name"],
                                  size: 18,
                                  colors: black,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 224, 224, 224),
                                            offset: Offset(1, 1),
                                            blurRadius: 4),
                                      ]),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("user-favourite-dishes")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("dishes")
                                        .where("name",
                                            isEqualTo: _dishes[index]["name"])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return const Text("");
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: IconButton(
                                          onPressed: () {
                                            snapshot.data.docs.length == 0
                                                ? addToFavouriteDishes(index)
                                                : Fluttertoast.showToast(
                                                    msg: "Already Added");
                                          },
                                          icon: snapshot.data.docs.length == 0
                                              ? const Icon(
                                                  Icons.favorite_border,
                                                  color: red,
                                                  size: 18,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 18,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
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
                                  child: TitleWidget(
                                    text: widget.restaurants.name,
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
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TitleWidget(
                                  text: "\$${_dishes[index]["price"]}",
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
            ),
          );
        },
      ),
    );
  }
}
