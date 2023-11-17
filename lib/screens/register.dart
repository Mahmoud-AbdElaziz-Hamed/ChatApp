// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? mail;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 48, 83),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Image.network(
                  "https://thumbs.dreamstime.com/b/cute-robot-png-background-generative-ai-274006024.jpg",
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text(
                    "My Chat",
                    style: TextStyle(
                        fontSize: 42,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hint: "Enter your Mail",
                  onChange: (data) {
                    mail = data;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  obscureText: true,
                  hint: "Enter your Password",
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: "Register",
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await registration();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Success"),
                      ));
                      Navigator.pushNamed(context, "chat");
                    } on FirebaseAuthException catch (ex) {
                      showSnakeBar(context, ex);
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    const Text(
                      "If you don't have an account ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Login ",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnakeBar(BuildContext context, FirebaseAuthException ex) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ex.toString(),
        ),
      ),
    );
  }

  Future<void> registration() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: mail!, password: password!);
  }
}
