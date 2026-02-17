import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<void> addToCart(String userId, AddToCartModel cartItem);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final _firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addToCart(String userId, AddToCartModel cartItem) async {
    return await _firestoreServices.setData(path: ApiPaths.cartItem(userId, cartItem.id), data: cartItem.toMap());
  }
}