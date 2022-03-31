import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:learningdart/Core/Model/Product.dart';

class ProductService {
  static const String FIREBASE_URL =
      "https://learningdart-4e105-default-rtdb.firebaseio.com/products.json";

  Future<List<Product>> getProducts() async {
    var url = Uri.parse(FIREBASE_URL);
    final response = await http.get(url);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonModel = json.decode(response.body) as Map;

        final List<Product> productList = [];

        jsonModel.forEach((key, value) {
          Product product = Product.fromJson(value);
          product.id = key;
          productList.add(product);
        });

        return productList;
      default:
        return Future.error(response.statusCode);
    }
  }

  Future<int> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(FIREBASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
