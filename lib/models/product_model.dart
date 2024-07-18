class Product {
  final String title;
  final String description;
  final double discountPercentage;
  final double price;
  final String thumbnail;

  Product({
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      discountPercentage: json['discountPercentage'].toDouble(),
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }

  double get discountedPrice {
    double discount = price * discountPercentage / 100;
    double discountedPrice = price - discount;
    return double.parse(discountedPrice.toStringAsFixed(2));
  }
}
