// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:learningdart/Core/Model/DesignProduct.dart';
import 'package:learningdart/UI/Views/Home/DesignProductDetail.dart';
import 'package:learningdart/UI/context_extensions.dart';

class PageDesign extends StatefulWidget {
  const PageDesign({Key? key}) : super(key: key);

  @override
  State<PageDesign> createState() => _PageDesignState();
}

class _PageDesignState extends State<PageDesign> {
  int _selectedIndex = 0;

  List<String> categories = [
    "T-shirts",
    "Chop tops",
    "Sleeveless",
    "Pants",
    "Vallets",
    "Jackets",
    "Shoes",
    "Phone",
    "Computer",
    "Mouse",
    "Keyboard"
  ];

  List<DesignProduct> products = [
    DesignProduct("Pullover", "Mango", 51, 4, false),
    DesignProduct("Blouse", "Dorothy Perkins", 34, 0, false),
    DesignProduct("T-Shirt", "LOST link", 12, 5, false),
    DesignProduct("Shirt", "Topshop", 51, 4, false),
    DesignProduct("Pullover", "Mango", 51, 4, false),
    DesignProduct("Blouse", "Dorothy Perkins", 34, 0, false),
    DesignProduct("T-Shirt", "LOST link", 12, 5, false),
    DesignProduct("Shirt", "Topshop", 51, 4, false),
    DesignProduct("Pullover", "Mango", 51, 4, false),
    DesignProduct("Blouse", "Dorothy Perkins", 34, 0, false),
    DesignProduct("T-Shirt", "LOST link", 12, 5, false),
    DesignProduct("Shirt", "Topshop", 51, 4, false),
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
            child: Container(
              color: Colors.white,
              width: context.dynamicWidth(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "My Title",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: context.dynamicHight(0.1),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  '${categories[index]}',
                                  style:
                                      Theme.of(context).primaryTextTheme.button,
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: context.dynamicHight(0.05),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _productCard(products[index]);
              },
              childCount: categories.length,
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

  AppBar _pageAppBarBuild(BuildContext context) {
    return AppBar(
      centerTitle: true,
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            // do something
          },
        )
      ],
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget get _waitingWidget => const Center(child: CircularProgressIndicator());

  Widget _productCard(DesignProduct product) {
    return Container(
      width: context.dynamicWidth(1),
      height: context.isPortrait()
          ? context.dynamicHight(0.17)
          : context.dynamicWidth(0.17),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DesignProductDetail(product)));
        },
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png",
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _waitingWidget;
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: context.dynamicHight(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 13,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
                        child: FittedBox(
                          child: Text(
                            '${product.name}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline5
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
                        child: FittedBox(
                          child: Text(
                            '${product.brand}',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall
                                ?.copyWith(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 7, 0, 0),
                        child: FittedBox(
                          child: Row(
                            children: [
                              product.point! <= 0
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.point! <= 1
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.point! <= 2
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.point! <= 3
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.point! <= 4
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 7, 0, 7),
                        child: FittedBox(
                          child: Text(
                            '${product.price} \$',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    product.isFav = !product.isFav;
                  });
                },
                icon: Icon(
                  product.isFav == true
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: product.isFav == true ? Colors.red : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}
