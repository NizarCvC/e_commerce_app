class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String products() => 'products/';
  static String cartItem(String userId, String cartItemId) =>
      'users/$userId/cart/$cartItemId';
  static String carouselItems() => 'announcements/';
  static String categories() => 'caretgories/';
  static String favoriteProduct(String userId, String productId) =>
      'users/$userId/favorites/$productId';
  static String favoriteProducts(String userId) =>
      'users/$userId/favorites/';
}
