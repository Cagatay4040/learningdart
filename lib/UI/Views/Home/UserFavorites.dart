import 'package:flutter/material.dart';
import 'package:learningdart/UI/context_extensions.dart';
import 'package:learningdart/Core/Model/DesignProduct.dart';
import 'package:learningdart/UI/Views/Home/DesignProductDetail.dart';

class UserFavorites extends StatefulWidget {
  const UserFavorites({Key? key}) : super(key: key);

  @override
  State<UserFavorites> createState() => _UserFavoritesState();
}

class _UserFavoritesState extends State<UserFavorites> {
  List<DesignProduct> products = [
    DesignProduct(
        1,
        "Pullover",
        {"renk": "mavi"},
        [
          "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png",
          "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png"
        ],
        "Mango",
        "model_mango",
        51,
        4),
    DesignProduct(
        4,
        "Shirt",
        {"renk": "Sarı"},
        [
          "https://static.zajo.net/content/mediagallery/zajo_dcat/image/product/types/X/9088.png"
        ],
        "Topshop",
        "model_Topshop",
        51,
        4),
  ];

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
                      "Favorilerim",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          ?.copyWith(color: Colors.black),
                    ),
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
              childCount: products.length,
            ),
          ),
        ],
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
                product.images![0],
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
                              product.rating! <= 0
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.rating! <= 1
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.rating! <= 2
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.rating! <= 3
                                  ? const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                              product.rating! <= 4
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
                  // setState(() {
                  //   product.isFav = !product.isFav;
                  // });
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
