import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/screens/delivery%20detail/delivery_information_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  num total = 0;
  num sum = 0;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("cart-items")
        .get()
        .then(
          // ignore: avoid_function_literals_in_foreach_calls
          (value) => value.docs.forEach(
            (element) {
              sum += element.data()["cart-item-price"] *
                  element.data()["cart-item-quantity"];
              setState(() {
                total = sum;
              });
            },
          ),
        );

    super.initState();
  }

  QuerySnapshot? items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Cart")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("cart-items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            items = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                SizedBox(
                  height: 450.h,
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // ignore: no_leading_underscores_for_local_identifiers
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 210, 206, 206),
                                offset: const Offset(3, 5),
                                blurRadius: 30.r,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 130.w,
                                height: 120.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.r),
                                    topLeft: Radius.circular(20.r),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        _documentSnapshot["cart-item-image"],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "${_documentSnapshot["cart-item-name"]}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${_documentSnapshot["cart-item-price"]}",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "qty : ${_documentSnapshot["cart-item-quantity"]}",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Cart")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("cart-items")
                                      .doc(_documentSnapshot.id)
                                      .delete();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  color: Colors.orange,
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Total : $total",
                      style: TextStyle(
                        color: black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  height: 50.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (snapshot.data!.docs.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryInformationScreen(
                              tprice: total,
                              cartItem: items,
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "The Cart is Empty!",
                          gravity: ToastGravity.CENTER,
                        );
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        color: white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
