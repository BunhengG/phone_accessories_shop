class ProductModel {
  final int id;
  final String title;
  final String subtitle;
  final String shortDescription;
  final String type;
  final String mainImage;
  final List<String> galleryImages;
  final DateTime createdAt;
  final int salesCount;
  final double price;
  final List<String> colors;

  ProductModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortDescription,
    required this.type,
    required this.mainImage,
    required this.galleryImages,
    required this.createdAt,
    required this.salesCount,
    required this.price,
    required this.colors,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      shortDescription: json['short_description'],
      type: json['type'],
      mainImage: json['main_image'],
      galleryImages: List<String>.from(json['gallery_images'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      salesCount: json['sales_count'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      colors: List<String>.from(json['colors'] ?? []),
    );
  }
}
