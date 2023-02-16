// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/screens/cart_screen.dart';
import 'package:my_food_ordering_app/widgets/title.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  int price;

  DetailsScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300.h,
              child: Stack(
                children: [
                  Carousel(
                    images: [
                      CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                      ),
                    ],
                    autoplay: false,
                    dotBgColor: white,
                    dotColor: grey,
                    dotIncreasedColor: red,
                    dotIncreaseSize: 1.2,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: white,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => const CartScreen());
                              },
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                color: white,
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 8.h,
                              right: 7.w,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Cart")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("cart-items")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: Text(""),
                                      );
                                    }
                                    return Container(
                                      padding: EdgeInsets.only(
                                        right: 3.w,
                                        left: 3.w,
                                        top: 1.h,
                                        bottom: 1.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: grey,
                                            offset: const Offset(2, 1),
                                            blurRadius: 3.r,
                                          ),
                                        ],
                                      ),
                                      child: TitleWidget(
                                        text: "${snapshot.data!.docs.length}",
                                        size: 16.sp,
                                        colors: red,
                                        weight: FontWeight.normal,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 70.h,
                    right: 25.w,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: grey,
                            offset: Offset(2, 3),
                            blurRadius: 3,
                          ),
                        ],
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.favorite,
                          size: 22.sp,
                          color: red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            TitleWidget(
              text: "${widget.name}\n",
              size: 26,
              colors: black,
              weight: FontWeight.bold,
            ),
            TitleWidget(
              text: "\$${widget.price}",
              size: 20,
              colors: red,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        if (qty > 1) {
                          qty--;
                        }
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 36,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text(
                    qty.toString(),
                    style: TextStyle(color: white, fontSize: 18.sp),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        qty++;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 36,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Cart")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection("cart-items")
                      .doc()
                      .set(
                    {
                      "cart-item-name": widget.name,
                      "cart-item-image": widget.image,
                      "cart-item-price": widget.price,
                      "cart-item-quantity": qty
                    },
                  ).then((value) =>
                          Fluttertoast.showToast(msg: "Added To Cart"));
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: white,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
