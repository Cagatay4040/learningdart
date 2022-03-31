class Product {
  String? id;
  String? name;
  int? price;
  String? producttype;

  Product({this.name, this.price, this.producttype});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    price = json['price'] ?? 0;
    producttype = json['producttype'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['price'] = price;
    data['producttype'] = producttype;
    return data;
  }
}
