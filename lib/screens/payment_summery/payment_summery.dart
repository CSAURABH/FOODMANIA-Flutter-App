import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_food_ordering_app/helpers/styles.dart';
import 'package:my_food_ordering_app/screens/payment_summery/order_items.dart';
import 'package:my_food_ordering_app/widgets/loading.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class PaymentSummeryScreen extends StatefulWidget {
  num tprice;
  QuerySnapshot<Object?>? current;
  QuerySnapshot<Object?>? cItems;
  PaymentSummeryScreen({
    Key? key,
    required this.tprice,
    required this.current,
    required this.cItems,
  }) : super(key: key);

  @override
  State<PaymentSummeryScreen> createState() => _PaymentSummeryScreenState();
}

String? fName;
String? lName;
String? address;
String? city;
String? state;
String? pinCode;
String? email;
String? mNumber;

class _PaymentSummeryScreenState extends State<PaymentSummeryScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    initializeRAzorPay();
  }

  void initializeRAzorPay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void launchRazorPay({amount}) {
    var options = {
      'key': 'rzp_test_vaCwf9jHxQAW8f',
      'amount': amount * 100, //in the smallest currency sub-unit.
      'name': 'Saurabh Chachere',
      'description': 'Zomato',
      'timeout': 300, // in seconds
      'prefill': {'contact': '123456782', 'email': 'chacheresaurabh@gmail.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      // ignore: avoid_print
      print("Error : $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // ignore: avoid_print
    print("Payment Successful");
    // ignore: avoid_print
    print(
        "${response.orderId} \n ${response.paymentId} \n ${response.signature}");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // ignore: avoid_print
    print("Payment Faild");
    // ignore: avoid_print
    print("${response.code} \n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // ignore: avoid_print
    print("Payment Faild");
  }

  int myType = 1;
  @override
  Widget build(BuildContext context) {
    num total = widget.tprice + 10;

    for (var post in widget.current!.docs) {
      fName = post["First-Name"];
      lName = post["Last-Name"];
      address = post["Address"];
      city = post["City"];
      state = post["State"];
      pinCode = post["Pin-Code"];
      email = post["Email"];
      mNumber = post["Mobile-No"];
    }

    void placeOrder({myType}) {
      FirebaseFirestore.instance
          .collection("order-place")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("order-history")
          .doc()
          .set(
        {
          "First-Name": fName,
          "Last-Name": lName,
          "Address": address,
          "City": city,
          "State": state,
          "Pin-Code": pinCode,
          "Email": email,
          "Phone-Number": mNumber,
          "Total-Amount": total,
          "Payment-Option": myType,
          "Ordered-Item": widget.cItems!.docs.length
        },
      );
    }

    Future<void> deleteCartItems() async {
      var collection = FirebaseFirestore.instance
          .collection('Cart')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("cart-items");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment Summery",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "${fName!} ${lName!}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //  "Plot No. 112, Pragati Nagar, Ranala, Kamptee, Nagpur, Maharashtra - 441001",
                    subtitle:
                        Text("${address!}, ${city!}, ${state!}, - ${pinCode!}"),
                  ),
                  Divider(
                    height: 25.h,
                    color: black,
                  ),
                  ExpansionTile(
                    title: Text("Order Item ${widget.cItems!.docs.length}"),
                    children: const [
                      OrderedItems(),
                    ],
                  ),
                  Divider(
                    height: 20.h,
                    color: black,
                  ),
                  ListTile(
                    leading: Text(
                      "Subtotal",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "\$ ${widget.tprice}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      "Delivery Fee",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "\$ 10",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "\$ $total",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 11.h,
                    color: black,
                  ),
                  ListTile(
                    leading: Text(
                      "Payment Option",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: myType,
                    onChanged: (value) {
                      setState(
                        () {
                          myType = value as int;
                        },
                      );
                    },
                    title: const Text("Cash On Delivery"),
                    secondary: const Icon(
                      Icons.home,
                      color: Colors.orange,
                    ),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: myType,
                    onChanged: (value) {
                      setState(
                        () {
                          myType = value as int;
                        },
                      );
                    },
                    title: const Text("Online Payment"),
                    secondary: const Icon(
                      Icons.wallet,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
        child: ListTile(
          title: const Text("Total Amount"),
          subtitle: Text(
            "\$ $total",
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          trailing: SizedBox(
            width: 170.w,
            height: 45.h,
            child: MaterialButton(
              onPressed: () {
                if (myType == 1) {
                  deleteCartItems();
                  placeOrder(myType: "Cash-On-Delivery");
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );
                } else {
                  placeOrder(myType: "Online");
                  deleteCartItems();
                  launchRazorPay(amount: total);
                }
              },
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                "Place Order",
                style: TextStyle(
                  color: black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
