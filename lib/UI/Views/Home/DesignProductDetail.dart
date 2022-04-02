// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/Comment.dart';
import 'package:learningdart/Core/Model/DesignProduct.dart';
import 'package:learningdart/UI/context_extensions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DesignProductDetail extends StatefulWidget {
  final DesignProduct myProduct;

  // ignore: use_key_in_widget_constructors
  const DesignProductDetail(this.myProduct);

  @override
  State<DesignProductDetail> createState() => _DesignProductDetailState();
}

class _DesignProductDetailState extends State<DesignProductDetail> {
  double userPoint = 0;
  int _selectedIndex = 0;

  int currentPos = 0;
  List<String> listPaths = [
    "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png",
    "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png",
    "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png",
  ];

  List<Comment> comments = [
    Comment("cagdulger1@gmail.com", DateTime.now(), "Çok güzel", 5),
    Comment("cagdulger2@gmail.com", DateTime.now(), "Tavsiye Ederim", 4),
    Comment("cagdulger3@gmail.com", DateTime.now(), "Ürün bozuk geldi", 1),
    Comment(
        "cagdulger4@gmail.com",
        DateTime.now(),
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        3),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageAppBarBuild(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: context.isPortrait()
                            ? context.dynamicHight(0.30)
                            : context.dynamicWidth(0.30),
                      ),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return Image.network(listPaths[itemIndex]);
                      },
                    ),
                    Container(
                      width: context.dynamicWidth(1),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.myProduct.name}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline3
                                ?.copyWith(color: Colors.black),
                          ),
                          const Divider(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Ürün Adı : ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
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
                                'Ürün Marka : ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.myProduct.brand}',
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
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: productPointSelector(context),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
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
                    width: context.dynamicWidth(1),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: RaisedButton(
                      child: const Text(
                        "Yorum Ekle",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _commentCard(comments[index]);
              },
              childCount: comments.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              color: _selectedIndex == 0 ? Colors.orange : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
              color: _selectedIndex == 1 ? Colors.orange : Colors.black,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? Icons.shopping_bag
                  : Icons.shopping_bag_outlined,
              color: _selectedIndex == 2 ? Colors.orange : Colors.black,
            ),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.favorite : Icons.favorite_outline,
              color: _selectedIndex == 3 ? Colors.orange : Colors.black,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4 ? Icons.person : Icons.person_outline,
              color: _selectedIndex == 4 ? Colors.orange : Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _commentCard(Comment comment) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    "${comment.email}",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 30,
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Icon(
                    comment.rating! >= 1 ? Icons.star : Icons.star_outline,
                    color: comment.rating! >= 1 ? Colors.yellow : Colors.black,
                    size: context.isPortrait()
                        ? context.dynamicWidth(0.05)
                        : context.dynamicHight(0.05),
                  ),
                  Icon(
                    comment.rating! >= 2 ? Icons.star : Icons.star_outline,
                    color: comment.rating! >= 2 ? Colors.yellow : Colors.black,
                    size: context.isPortrait()
                        ? context.dynamicWidth(0.05)
                        : context.dynamicHight(0.05),
                  ),
                  Icon(
                    comment.rating! >= 3 ? Icons.star : Icons.star_outline,
                    color: comment.rating! >= 3 ? Colors.yellow : Colors.black,
                    size: context.isPortrait()
                        ? context.dynamicWidth(0.05)
                        : context.dynamicHight(0.05),
                  ),
                  Icon(
                    comment.rating! >= 4 ? Icons.star : Icons.star_outline,
                    color: comment.rating! >= 4 ? Colors.yellow : Colors.black,
                    size: context.isPortrait()
                        ? context.dynamicWidth(0.05)
                        : context.dynamicHight(0.05),
                  ),
                  Icon(
                    comment.rating! >= 5 ? Icons.star : Icons.star_outline,
                    color: comment.rating! >= 5 ? Colors.yellow : Colors.black,
                    size: context.isPortrait()
                        ? context.dynamicWidth(0.05)
                        : context.dynamicHight(0.05),
                  ),
                ]),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
              "${comment.comment}",
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Container productPointSelector(BuildContext context) {
    return Container(
      width: context.dynamicWidth(1),
      height: context.dynamicHight(0.10),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      color: Colors.white,
      child: Row(children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Puanınız : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: RatingBar.builder(
            itemSize: context.isPortrait()
                ? context.dynamicWidth(0.05)
                : context.dynamicHight(0.05),
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              userPoint = rating;
              print(userPoint);
            },
          ),
        ),
      ]),
    );
  }

  AppBar _pageAppBarBuild(BuildContext context) {
    return AppBar(
      centerTitle: true,
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            widget.myProduct.isFav ? Icons.favorite : Icons.favorite_outline,
            color: widget.myProduct.isFav ? Colors.red : Colors.black,
          ),
          onPressed: () {
            setState(() {
              widget.myProduct.isFav = !widget.myProduct.isFav;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.black,
          onPressed: () {
            Share.share('check out my website https://example.com/',
                subject: 'Look what I made!');
          },
        )
      ],
    );
  }
}
