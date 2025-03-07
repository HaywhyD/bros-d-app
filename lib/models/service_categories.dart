class ServiceCategories {
  final String title;
  final String imageUrl;
  final int rating;
  final List<ServiceCategoryDetail>? details;

  const ServiceCategories({
    required this.title,
    required this.imageUrl,
    required this.rating,
    this.details,
  });

  factory ServiceCategories.fromJson(Map<String, dynamic> json) {
    final detail = <ServiceCategoryDetail>[];
    for (var detail in ((json["detail"] ?? []) as List)) {
      detail.add(ServiceCategoryDetail.fromJson(detail));
    }
    return ServiceCategories(
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        rating: json['rating'] as int,
        details: detail);
  }
}

class ServiceCategoryDetail {
  final String title;
  final String imageUrl;
  final int rating;

  const ServiceCategoryDetail({
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  factory ServiceCategoryDetail.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryDetail(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: json['rating'] as int,
    );
  }
}
