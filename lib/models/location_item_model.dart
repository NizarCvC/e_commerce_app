class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imageUrl;
  final bool isChosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.isChosen = false,
    this.imageUrl =
        'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*8ZhgsyCNQRDaKEB7Rk_Udw.jpeg',
  });

  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imageUrl,
    bool? isChosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imageUrl: imageUrl ?? this.imageUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LocationItemModel> locations = [
  LocationItemModel(
    id: '1',
    city: 'Madinah',
    country: 'Saudi Arabia',
    isChosen: true,
  ),
  LocationItemModel(id: '2', city: 'Makkah', country: 'Saudi Arabia'),
  LocationItemModel(id: '3', city: 'Jeddah', country: 'Saudi Arabia'),
  LocationItemModel(id: '4', city: 'Tabuk', country: 'Saudi Arabia'),
];
