import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isLoading = true;

  Future<void> waitForLoading() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    waitForLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Learning Flutter",
            style: Theme.of(context)
                .primaryTextTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : mySizedBox(context));
  }

  SizedBox mySizedBox(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              color: Colors.orange,
              child: Center(child: Text("$index")),
            );
          }),
    );
  }
}
