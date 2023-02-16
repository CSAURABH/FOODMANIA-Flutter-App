import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_food_ordering_app/screens/login_screen.dart';
import 'package:my_food_ordering_app/widgets/profile_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    void cropImage(XFile file) async {
      File? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20,
      );

      if (croppedImage != null) {
        setState(() {
          imageFile = croppedImage;
        });
      }
    }

    void selectImage(ImageSource source) async {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        cropImage(pickedFile);
      }
    }

    void showPhotoOption() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Galary"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                CupertinoButton(
                  onPressed: () {
                    showPhotoOption();
                  },
                  child: CircleAvatar(
                    backgroundImage:
                        (imageFile != null) ? FileImage(imageFile!) : null,
                    radius: 60.r,
                    child: (imageFile == null)
                        ? const Icon(
                            Icons.add_a_photo_rounded,
                            size: 60,
                          )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Edit photo"),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Saurabh Chachere",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ProfileItems(
                  text: "Payments",
                  icon: Icons.account_balance_wallet,
                  bcolor: Colors.blue,
                ),
                const ProfileItems(
                  text: "Profile Settings",
                  icon: Icons.settings,
                  bcolor: Colors.blue,
                ),
                const ProfileItems(
                  text: "Order History",
                  icon: Icons.book,
                  bcolor: Color.fromARGB(189, 34, 112, 45),
                ),
                const ProfileItems(
                  text: "Booking",
                  icon: Icons.search,
                  bcolor: Color.fromARGB(255, 216, 200, 51),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 50.h,
                  width: 200.w,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0.r),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
