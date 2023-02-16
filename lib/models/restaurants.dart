// To parse this JSON data, do
//
//     final restaurants = restaurantsFromJson(jsonString);

import 'dart:convert';

List<Restaurants> restaurantsFromJson(String str) => List<Restaurants>.from(
    json.decode(str).map((x) => Restaurants.fromJson(x)));

String restaurantsToJson(List<Restaurants> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurants {
  Restaurants({
    required this.id,
    required this.name,
    required this.foods,
    required this.image,
    required this.ratings,
  });

  int id;
  String name;
  String foods;
  String image;
  double ratings;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        foods: json["foods"],
        image: json["image"],
        ratings: json["ratings"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "foods": foods,
        "image": image,
        "ratings": ratings,
      };
}
