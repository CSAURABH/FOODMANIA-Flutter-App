import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_food_ordering_app/helpers/styles.dart';

class OrderedItems extends StatefulWidget {
  const OrderedItems({Key? key}) : super(key: key);

  @override
  State<OrderedItems> createState() => _OrderedItemsState();
}

class _OrderedItemsState extends State<OrderedItems> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Cart")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("cart-items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // ignore: no_leading_underscores_for_local_identifiers
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 210, 206, 206),
                          offset: Offset(3, 5),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: _documentSnapshot["cart-item-image"],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${_documentSnapshot["cart-item-name"]}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Price: ${_documentSnapshot["cart-item-price"]}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "qty : ${_documentSnapshot["cart-item-quantity"]}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Icon(null),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
