import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
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
}
