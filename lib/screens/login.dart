import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

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
                //size box
                const SizedBox(
                  height: 35,
                ),
                Image.network(
                  "https://thumbs.dreamstime.com/b/cute-robot-png-background-generative-ai-274006024.jpg",
                  width: 120,
                  height: 120,
                ),
                //size box
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
                //size box

                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
                //size box
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hint: "Enter your Mail",
                  onChange: (data) {
                    email = data;
                  },
                ),
                //size box
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
                //size box
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: "Sign in",
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await login();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Success")));
                      Navigator.pushNamed(context, "chat", arguments: email);
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
                        Navigator.pushNamed(context, "Register",
                            arguments: email);
                      },
                      child: const Text("Sign up ",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 18)),
                    ),
                  ],
                ),
                //size box
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

  Future<void> login() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
