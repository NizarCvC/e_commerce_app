import 'package:e_commerce_app/models/add_to_cart_model.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/utils/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
  Future<void> addToCart(String userId, AddToCartModel cartItem);
}

class CartServicesImpl extends CartServices {
  final _firestoreServices = FirestoreServices.instance;

  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async {
    return _firestoreServices.getCollection(
      path: ApiPaths.cartItems(userId),
      builder: (data, documentId) => AddToCartModel.fromMap(data),
    );
  }

  @override
  Future<void> addToCart(String userId, AddToCartModel cartItem) async {
    return await _firestoreServices.setData(
      path: ApiPaths.cartItem(userId, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
