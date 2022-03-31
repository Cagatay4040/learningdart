import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/Product.dart';
import 'package:learningdart/Core/Services/ProductService.dart';
import 'package:learningdart/UI/Views/Home/CreateProduct.dart';
import 'package:learningdart/UI/Views/Home/ProductDetail.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late ProductService service;

  @override
  void initState() {
    super.initState();
    service = ProductService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: Theme.of(context)
              .primaryTextTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: service.getProducts(),
          builder: (contex, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data as List<Product>;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: RaisedButton(
                                child: const Text(
                                  "Ürün Ekle",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateProduct()));
                                }),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _productCard(products[index]);
                            },
                            childCount: products.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return _notFoundWidget;
                }
              default:
                return _waitingWidget;
            }
          }),
    );
  }

  // Widget _listProduct(List<Product> products) {
  //   return ListView.builder(
  //       itemCount: products.length,
  //       itemBuilder: (context, index) {
  //         return _productCard(products[index]);
  //       });
  // }

  Widget _productCard(Product product) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductDetail(product)));
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Ürün Adı : ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.name}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Ürün Tipi : ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.producttype}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Ürün Fiyatı : ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.price}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.shade200,
            Colors.white,
          ],
        ),
      ),
    );
  }

  Widget get _notFoundWidget => const Center(child: Text("Not Found"));

  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());
}
