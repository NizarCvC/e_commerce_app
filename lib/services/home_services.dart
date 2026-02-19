import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/home_carousel_item_model.dart';
import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
}

class HomeServicesImpl implements HomeServices {
  final _firestoreService = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await _firestoreService.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchCarouselItems() async {
    return await _firestoreService.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.carouselItems(),
      builder: (data, documentId) =>
          HomeCarouselItemModel.fromMap(data, documentId),
    );
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    return await _firestoreService.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(data, documentId),
    );
  }
}
