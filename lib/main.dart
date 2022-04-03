import 'package:flutter/material.dart';
import 'package:learningdart/UI/Views/Authentication/loginView.dart';
import 'package:learningdart/UI/Views/Home/HomePage.dart';

import 'UI/Views/Home/PageDesign.dart';
//import 'package:learningdart/UI/Views/Home/InfinityTextField.dart';
// import 'UI/Views/Home/ProductPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey.shade100),
      home: const HomePage(),
    );
  }
}
