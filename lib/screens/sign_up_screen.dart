import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_food_ordering_app/screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cpasswordController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();

    void singUp() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String cpassword = cpasswordController.text.trim();
      String fname = fullNameController.text.trim();

      if (email == "" || password == "" || cpassword == "" || fname == "") {
        Fluttertoast.showToast(msg: "Please fill all the fields!");
      } else if (password != cpassword) {
        Fluttertoast.showToast(msg: "Passward do not match");
      } else {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Fluttertoast.showToast(msg: "The Password Provided is to weak");
          } else if (e.code == 'email-already-in-use') {
            Fluttertoast.showToast(
                msg: "The account already exists for that email.");
          }
        }
      }
    }

    sendUserToDB() {
      String email = emailController.text.trim();
      String fname = fullNameController.text.trim();

      CollectionReference user = FirebaseFirestore.instance.collection("user");

      return user.doc(email).set(
        {
          "Full-Name": fname,
          "Email-Id": emailController.text,
        },
      ).then(
        (value) => {
          Navigator.popUntil(context, (route) => route.isFirst),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          )
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
                color: Color.fromARGB(255, 222, 99, 43),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 195, 195),
                          blurRadius: 20.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 195, 195),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 195, 195),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 202, 195, 195),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: cpasswordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        singUp();
                        sendUserToDB();
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 88, 86, 86),
                        ),
                      ),
                      GestureDetector(
                        child: const Text(
                          " Log in",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 210, 91, 31),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
