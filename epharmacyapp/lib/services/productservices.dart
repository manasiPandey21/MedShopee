import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epharmacyapp/constants/firebaseconstants.dart';
import 'package:epharmacyapp/models/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
