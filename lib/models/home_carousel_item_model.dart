class HomeCarouselItemModel {
  final String id;
  final String imageUrl;

  HomeCarouselItemModel({required this.id, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory HomeCarouselItemModel.fromMap(Map<String, dynamic> map, String documentId) {
    return HomeCarouselItemModel(
      id: documentId,
      imageUrl: map['imageUrl'] as String,
    );
  }
}