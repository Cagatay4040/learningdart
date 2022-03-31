import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/Product.dart';
import 'package:learningdart/Core/Services/ProductService.dart';
import 'package:learningdart/UI/Views/Home/ProductPage.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  late ProductService service;

  late final TextEditingController _productNameController;
  late final TextEditingController _productTypeController;
  late final TextEditingController _priceController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    service = ProductService();
    _productNameController = TextEditingController();
    _productTypeController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productTypeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: _productNameController,
              keyboardType: TextInputType.name,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Ürün Adı"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: _productTypeController,
              keyboardType: TextInputType.name,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Ürün Tipi"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Fiyatı"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RaisedButton(
                child: const Text(
                  "Ürün Ekle",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                onPressed: () async {
                  Product product = new Product();
                  product.name = _productNameController.text;
                  product.producttype = _productTypeController.text;
                  product.price = int.parse(_priceController.text);

                  int myProduct = await service.createProduct(product);

                  if (myProduct == 200) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Products()));
                  }
                }),
          ),
        ]),
      ),
    );
  }
}
