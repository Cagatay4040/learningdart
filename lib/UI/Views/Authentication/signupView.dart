// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learningdart/UI/Views/Authentication/loginView.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupView createState() => _SignupView();
}

class _SignupView extends State<SignupView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _password2Controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  Future<FirebaseApp> _initializerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future signUpUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializerFirebase(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          enableSuggestions: false,
                          //obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Şifre"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: TextFormField(
                          controller: _password2Controller,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          enableSuggestions: false,
                          //obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Şifre Tekrar"),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: RaisedButton(
                            child: const Text(
                              "Kaydol",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.blue,
                            onPressed: () async {
                              await signUpUsingEmailPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginView()));
                            }),
                      ),
                    ]),
              );

            default:
              return _waitingWidget;
          }

          // if (snapshot.connectionState == ConnectionState.done) {
          //   return Form(
          //     key: _formKey,
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          //             child: TextFormField(
          //               controller: _emailController,
          //               keyboardType: TextInputType.emailAddress,
          //               autocorrect: false,
          //               decoration: const InputDecoration(
          //                   border: OutlineInputBorder(), labelText: "Email"),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          //             child: TextFormField(
          //               controller: _passwordController,
          //               keyboardType: TextInputType.visiblePassword,
          //               autocorrect: false,
          //               enableSuggestions: false,
          //               //obscureText: true,
          //               decoration: const InputDecoration(
          //                   border: OutlineInputBorder(), labelText: "Şifre"),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          //             child: TextFormField(
          //               controller: _password2Controller,
          //               keyboardType: TextInputType.visiblePassword,
          //               autocorrect: false,
          //               enableSuggestions: false,
          //               //obscureText: true,
          //               decoration: const InputDecoration(
          //                   border: OutlineInputBorder(),
          //                   labelText: "Şifre Tekrar"),
          //             ),
          //           ),
          //           Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          //             child: RaisedButton(
          //                 child: const Text(
          //                   "Kaydol",
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //                 color: Colors.blue,
          //                 onPressed: () async {
          //                   await signUpUsingEmailPassword(
          //                       email: _emailController.text,
          //                       password: _passwordController.text,
          //                       context: context);

          //                   Navigator.of(context).pushReplacement(
          //                       MaterialPageRoute(
          //                           builder: (context) => const LoginView()));
          //                 }),
          //           ),
          //         ]),
          //   );
          // } else {
          //   return _waitingWidget;
          // }
        },
      ),
    );
  }

  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());
}
