import 'package:releae/features/card/cardModel.dart';

class FavoriteModel {
  final String id;
  final String title;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime favoritedAt;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
    required this.favoritedAt,
  });

  factory FavoriteModel.fromCard(CardModel card) {
    return FavoriteModel(
      id: card.id,
      title: card.title,
      description: card.description,
      createdAt: card.createdAt,
      updatedAt: card.updatedAt,
      favoritedAt: DateTime.now(),
    );
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString())
          : null,
      favoritedAt:
          DateTime.tryParse(map['favorited_at'].toString()) ?? DateTime.now(),
    );
  }

  CardModel toCardModel() {
    return CardModel(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'favorited_at': favoritedAt.toIso8601String(),
    };
  }
}
