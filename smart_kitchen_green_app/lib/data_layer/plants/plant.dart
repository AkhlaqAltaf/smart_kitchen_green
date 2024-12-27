class Plant {
  final int id;
  final String name;
  final String category;
  final String bestgrow;
  final String img;
  final String water_time;

  Plant(
      {required this.id,
      required this.name,
      required this.category,
      required this.bestgrow,
      required this.img,
      required this.water_time});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      bestgrow: json['bestgrow'],
      img: json['img'] != null ? json['img'] : ".jpg",
      water_time:
          json['water_time'] != null ? json['water_time'] : "Not Available",
    );
  }
}
