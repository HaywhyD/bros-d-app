class Professionals {
  final String title;
  final String designation;
  final String imageUrl;
  final int rating;

  const Professionals({
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.designation,
  });

  factory Professionals.fromJson(Map<String, dynamic> json) {
    return Professionals(
      title: json['title'] as String,
      designation: json['designation'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: json['rating'] as int,
    );
  }
}
