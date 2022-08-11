import 'package:flutter_template/model/add_by_status_model.dart';

class GameModel {
  String? name;
  String? released;
  String? background_image;
  double? rating;
  AddByStatusModel? added_by_status;

  GameModel({
    this.name,
    this.released,
    this.background_image,
    this.rating,
    this.added_by_status,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        name: json['name'],
        released: json['released'],
        background_image: json['background_image'],
        rating: json['rating'],
        added_by_status: AddByStatusModel.fromJson(json["added_by_status"]),
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'released': released,
      'background_image': background_image,
      'rating': rating,
      'added_by_status': added_by_status,
    };
  }
}
