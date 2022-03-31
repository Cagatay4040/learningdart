import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/User.dart';
import 'package:learningdart/Core/Services/FirebaseService.dart';

class FireHome extends StatefulWidget {
  const FireHome({Key? key}) : super(key: key);

  @override
  _FireHome createState() => _FireHome();
}

class _FireHome extends State<FireHome> {
  late FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
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
      body: FutureBuilder(
          future: service.getUsers(),
          builder: (contex, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return _listUser(snapshot.data as List<User>);
                } else {
                  return _notFoundWidget;
                }
              default:
                return _waitingWidget;
            }
          }),
    );
  }

  Widget _listUser(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return _userCard(users[index]);
        });
  }

  Widget _userCard(User user) {
    return Card(
      child: ListTile(
        title: Text("${user.name}"),
      ),
    );
  }

  Widget get _notFoundWidget => const Center(child: Text("Not Found"));

  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());
}
