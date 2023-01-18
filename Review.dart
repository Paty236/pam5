class Review {
  int id;
  String first_name;
  String last_name;
  String image;
  int rating;
  String message;

  Review({
    this.id,
    this.first_name,
    this.last_name,
    this.image,
    this.rating,
    this.message});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      first_name: json['first_name']?? '',
      last_name: json['last_name']?? '',
      image: json['image']?? '',
      rating: json['rating']?? '',
      message: json['message']?? '',
    );
  }

}