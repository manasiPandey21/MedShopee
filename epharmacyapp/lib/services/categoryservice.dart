import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epharmacyapp/constants/firebaseconstants.dart';
import 'package:epharmacyapp/models/categoryModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/firebaseproviders.dart';

final categoriesServiceProvider=Provider((ref)=>CategoriesService(fireStore: ref.watch(FirebaseFirestoreProvider)));
class CategoriesService {
  final FirebaseFirestore _fireStore;
  CategoriesService({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  CollectionReference get _categories =>
      _fireStore.collection(FirebaseConstants.categories);

  Stream<List<Categories>> getCategories() {
    return _categories.snapshots().map((event){
      List<Categories>categoriesList=[];
      for (var doc in event.docs){
        categoriesList.add(Categories.fromMap(doc.data() as Map<String,dynamic>));
      }
      return categoriesList;
    });
  }
}
