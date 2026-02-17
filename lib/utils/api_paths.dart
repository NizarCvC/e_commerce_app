class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String products() => 'products/';
  static String cartItem(String userId, String cartItemId) =>
      'users/$userId/cart/$cartItemId';
}
