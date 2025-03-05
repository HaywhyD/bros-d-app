class ServiceCategories {
  final String title;
  final String imageUrl;
  final int rating;

  const ServiceCategories({
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  factory ServiceCategories.fromJson(Map<String, dynamic> json) {
    return ServiceCategories(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: json['rating'] as int,
    );
  }
}
