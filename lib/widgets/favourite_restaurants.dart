import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';

class FavouriteRestaurants extends StatelessWidget {
  const FavouriteRestaurants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user-favourite-restaurants")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("restaurants")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // ignore: no_leading_underscores_for_local_identifiers
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: Image.asset("assets/images/restro.jpg"),
                      ),
                      Positioned(
                        right: 20.w,
                        top: 20.h,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.sp,
                          child: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("user-favourite-restaurants")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("restaurants")
                                  .doc(_documentSnapshot.id)
                                  .delete();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.sp),
                                bottomRight: Radius.circular(20.sp),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.05),
                                  Colors.black.withOpacity(0.025),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, bottom: 10.h),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${_documentSnapshot["restaurant-name"]}\n",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            "${_documentSnapshot["restaurant-dishes"]}\n",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ],
                                    style: const TextStyle(color: white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 20.h, right: 20.w),
                                child: Container(
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(4.0.sp),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.yellow[900],
                                          size: 20,
                                        ),
                                      ),
                                      Text(_documentSnapshot[
                                              "restaurant-ratings"]
                                          .toString()),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
