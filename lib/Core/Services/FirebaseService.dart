import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:learningdart/Core/Model/User.dart';

class FirebaseService {
  static const String FIREBASE_URL =
      "https://learningdart-4e105-default-rtdb.firebaseio.com/Users.json";

  Future<List<User>> getUsers() async {
    var url = Uri.parse(FIREBASE_URL);
    final response = await http.get(url);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body);
        final userList = jsonModel
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList()
            .cast<User>();
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }
}
