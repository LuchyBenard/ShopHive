class ProductModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    required this.rating,
    required this.reviewCount,
});
}