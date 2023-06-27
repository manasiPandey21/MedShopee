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
}
