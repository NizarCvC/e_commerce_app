import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';

abstract class FavoriteServices {
  Future<List<ProductItemModel>> fetchFavoritesProducts(String userId);
  Future<void> addFavoriteProduct(String userId, ProductItemModel product);
  Future<void> removeFavoriteProduct(String userId, String productId);
}

class FavoriteServicesImpl implements FavoriteServices {
  final _firestoreService = FirestoreServices.instance;
  
  @override
  Future<void> addFavoriteProduct(
    String userId,
    ProductItemModel product,
  ) async {
    return await _firestoreService.setData(
      path: ApiPaths.favoriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFavoriteProduct(String userId, String productId) async {
    return await _firestoreService.deleteData(
      path: ApiPaths.favoriteProduct(userId, productId),
    );
  }

  @override
  Future<List<ProductItemModel>> fetchFavoritesProducts(String userId) async {
    return await _firestoreService.getCollection(
      path: ApiPaths.favoriteProducts(userId),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
  }
}