

class Category {
  String name;
  String icon;

  Category({this.name, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}