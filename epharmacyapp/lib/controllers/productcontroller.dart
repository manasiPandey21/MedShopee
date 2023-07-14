import 'package:epharmacyapp/models/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/productservices.dart';

final productsControllerProvider =
    StateNotifierProvider<ProductController, bool>((ref) {
  final productsService = ref.watch(productsServiceProvider);

  return ProductController(
    productService: productsService,
    ref: ref,
  );
});
final getProductsProvider = StreamProvider(
    (ref) => ref.watch(productsControllerProvider.notifier).getProducts());
    
final getProductByCategoryNameProvider =
    StreamProvider.family((ref, String categoryname) {
  return ref
      .watch(productsControllerProvider.notifier)
      .getProductByCategoryName(categoryname);
});

final relatedProductsProvider =
    StreamProvider.family((ref, String categoryname) {
  return ref
      .watch(productsControllerProvider.notifier)
      .getRelatedProducts(categoryname);
});

class ProductController extends StateNotifier<bool> {
  final ProductService _productService;
  final Ref _ref;

  ProductController({
    required ProductService productService,
    required Ref ref,
  })  : _productService = productService,
        _ref = ref,
        super(false);
  Stream<List<ProductModel>> getProducts() {
    return _productService.getProducts();
  }

  Stream<ProductModel> getProductsById(String productId) {
    return _productService.getProductById(productId);
  }
   Stream<List<ProductModel>> getProductByCategoryName(String categoryname) {
    return _productService.getProductsByCategoryName(categoryname);
  }

  Stream<List<ProductModel>> getRelatedProducts(String categoryname) {
    return _productService.getRelatedProducts(categoryname);
  }
}
