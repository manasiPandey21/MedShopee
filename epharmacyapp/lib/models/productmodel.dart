// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String? productId;
  String? image;
  String? name;
  double? price;
  double? oldprice;
  bool? isAvailable;
  String? description;
  String? categoryname;
  ProductModel({
    this.productId,
    this.image,
    this.name,
    this.price,
    this.oldprice,
    this.isAvailable,
    this.description,
    this.categoryname,
  });

  ProductModel copyWith({
    String? productId,
    String? image,
    String? name,
    double? price,
    double? oldprice,
    bool? isAvailable,
    String? description,
    String? categoryname,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      oldprice: oldprice ?? this.oldprice,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      categoryname: categoryname ?? this.categoryname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'image': image,
      'name': name,
      'price': price,
      'oldprice': oldprice,
      'isAvailable': isAvailable,
      'description': description,
      'categoryname': categoryname,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      oldprice: map['oldprice'] != null ? map['oldprice'] as double : null,
      isAvailable: map['isAvailable'] != null ? map['isAvailable'] as bool : null,
      description: map['description'] != null ? map['description'] as String : null,
      categoryname: map['categoryname'] != null ? map['categoryname'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productId: $productId, image: $image, name: $name, price: $price, oldprice: $oldprice, isAvailable: $isAvailable, description: $description, categoryname: $categoryname)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.image == image &&
      other.name == name &&
      other.price == price &&
      other.oldprice == oldprice &&
      other.isAvailable == isAvailable &&
      other.description == description &&
      other.categoryname == categoryname;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      image.hashCode ^
      name.hashCode ^
      price.hashCode ^
      oldprice.hashCode ^
      isAvailable.hashCode ^
      description.hashCode ^
      categoryname.hashCode;
  }
}
