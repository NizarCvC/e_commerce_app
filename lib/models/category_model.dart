class CategoryModel {
  final int id;
  final String name;
  final int productsCount;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.imageUrl,
  });
}

List<CategoryModel> categories = [
  CategoryModel(
    id: 1,
    name: 'New Arrivals',
    productsCount: 234,
    imageUrl:
        'https://img.freepik.com/free-photo/flatlay-outfit-travel_53876-138233.jpg?t=st=1769225984~exp=1769229584~hmac=639abe07b6522358f258143134f3027d6054b23b335ff2af9018a87a5c546c87',
  ),
  CategoryModel(
    id: 2,
    name: 'Watches',
    productsCount: 32,
    imageUrl:
        'https://images.pexels.com/photos/9131684/pexels-photo-9131684.jpeg',
  ),
  CategoryModel(
    id: 3,
    name: 'Bags',
    productsCount: 132,
    imageUrl:
        'https://images.pexels.com/photos/9327162/pexels-photo-9327162.jpeg',
  ),
  CategoryModel(
    id: 4,
    name: 'Clothes',
    productsCount: 589,
    imageUrl:
        'https://images.pexels.com/photos/6461400/pexels-photo-6461400.jpeg',
  ),
];
