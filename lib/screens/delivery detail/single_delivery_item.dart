import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleDeliveryItem extends StatelessWidget {
  String title;
  String address;
  String city;
  String state;
  String pinCode;
  String mobileNo;
  SingleDeliveryItem({
    Key? key,
    required this.title,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.mobileNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.orange,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              Row(
                children: [
                  Text(
                    "$city,",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("$state,"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("- $pinCode"),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text("+91 $mobileNo"),
            ],
          ),
        ),
        const Divider(
          height: 35,
        ),
      ],
    );
  }
}
