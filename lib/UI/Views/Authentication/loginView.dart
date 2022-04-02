// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/UI/Views/Authentication/signupView.dart';
import 'package:learningdart/UI/Views/Home/ProductPage.dart';
import 'package:learningdart/UI/context_extensions.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<FirebaseApp> _initializerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return null;
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          SizedBox(
            height: context.dynamicHight(0.25),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: context.dynamicWidth(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: FutureBuilder(
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                "Giriş Yap",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline4
                                    ?.copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: TextField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                enableSuggestions: false,
                                obscureText: true,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Şifre"),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: RaisedButton(
                                  child: const Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.blue,
                                  onPressed: () async {
                                    User? user = await loginUsingEmailPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        context: context);

                                    if (user != null) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Products()));
                                    } else {
                                      loginErrorPopup(context);
                                    }
                                  }),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Üye değilmisin',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupView()));
                                    },
                                    child: Text(
                                      'Üye Ol',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .button
                                          ?.copyWith(
                                            color: Colors.blue,
                                          ),
                                    ),
                                  ),
                                ]),
                          ]),
                    );

                  default:
                    return _waitingWidget;
                }
              },
            ),
          ),
          SizedBox(
            height: context.dynamicHight(0.25),
          ),
        ],
      ),
    );
  }

  Future<dynamic> loginErrorPopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Hata",
          style: Theme.of(context)
              .primaryTextTheme
              .headline5
              ?.copyWith(color: Colors.black),
        ),
        content: Text(
          "Kullanıcı adı veya şifre hatalı",
          style: Theme.of(context)
              .primaryTextTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
        ),
        elevation: 10.0,
        actions: [
          TextButton(
            child: const Text('Tamam'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());
}
