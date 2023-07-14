import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epharmacyapp/constants/firebaseconstants.dart';
import 'package:epharmacyapp/models/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../core/failure.dart';
import '../providers/firebaseproviders.dart';

final productsServiceProvider = Provider((ref) {
  return ProductService(firestore: ref.watch(FirebaseFirestoreProvider));
});

class ProductService {
  final FirebaseFirestore _firestore;

  ProductService({required FirebaseFirestore firestore})
      : _firestore = firestore;
       CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);

  Stream<List<ProductModel>> getProducts() {
    return _products.snapshots().map((event) {
      List<ProductModel> products = [];

      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
      }

      return products;
    });
  }

  Stream<ProductModel> getProductById(String productId) {
    return _products.doc(productId).snapshots().map(
        (event) => ProductModel.fromMap((event.data() as Map<String, dynamic>)));
  }
  Stream<List<ProductModel>> searchProducts(String query) {
    return _products
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var product in event.docs) {
        products.add(ProductModel.fromMap(product.data() as Map<String, dynamic>));
      }
      return products;
    });
  }

  Either<dynamic, Future<void>> updateProduct(ProductModel product) {
    try {
      return right(
          _products.doc(product.productId.toString()).update(product.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Stream<List<ProductModel>> getProductsByCategoryName(String categoryname) {
    return _products
        .where("categoryname", isEqualTo: categoryname)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return products;
    });
  }

  Stream<List<ProductModel>>getRelatedProducts(String categoryname){
     return _products
        .where("categoryname", isEqualTo: categoryname)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return products;
    });
  }
}


