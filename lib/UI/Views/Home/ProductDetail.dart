// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/Product.dart';

class ProductDetail extends StatefulWidget {
  final Product myProduct;

  // ignore: use_key_in_widget_constructors
  const ProductDetail(this.myProduct);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int userPoint = 0;

  @override
  Widget build(BuildContext context) {
    double starSize = MediaQuery.of(context).size.width * 0.07;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.myProduct.name}",
          style: Theme.of(context)
              .primaryTextTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
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
                            '${widget.myProduct.name}',
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
                            '${widget.myProduct.producttype}',
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
                            '${widget.myProduct.price}',
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
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: productPointSelector(context, starSize),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  const TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Yorum Yapın"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: RaisedButton(
                        child: const Text(
                          "Yorum Ekle",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return _productCard(products[index]);
          //     },
          //     childCount: products.length,
          //   ),
          // ),
        ],
      ),
    );
  }

  Container productPointSelector(BuildContext context, double starSize) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(children: [
        const Text(
          "Puanınız : ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                userPoint = 1;
              });
            },
            icon: userPoint >= 1
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: starSize,
                  )
                : Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: starSize,
                  )),
        IconButton(
            onPressed: () {
              setState(() {
                userPoint = 2;
              });
            },
            icon: userPoint >= 2
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: starSize,
                  )
                : Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: starSize,
                  )),
        IconButton(
            onPressed: () {
              setState(() {
                userPoint = 3;
              });
            },
            icon: userPoint >= 3
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: starSize,
                  )
                : Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: starSize,
                  )),
        IconButton(
            onPressed: () {
              setState(() {
                userPoint = 4;
              });
            },
            icon: userPoint >= 4
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: starSize,
                  )
                : Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: starSize,
                  )),
        IconButton(
            onPressed: () {
              setState(() {
                userPoint = 5;
              });
            },
            icon: userPoint == 5
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: starSize,
                  )
                : Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: starSize,
                  )),
      ]),
    );
  }
}
