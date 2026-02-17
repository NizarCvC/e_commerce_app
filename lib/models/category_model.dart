class CategoryModel {
  final String id;
  final String name;
  final int productCount;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productCount,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productCount': productCount,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CategoryModel(
      id: documentId,
      name: map['name'] as String,
      productCount: map['productCount'] as int,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
