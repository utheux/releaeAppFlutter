class CardModel {
  final String id;
  final String title;
  final String description;
  final int reviewStep;
  final DateTime? nextReviewAt;
  final DateTime? lastReviewAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CardModel({
    required this.id,
    required this.title,
    required this.description,
    this.reviewStep = 0,
    this.nextReviewAt,
    this.lastReviewAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    final id = json['_id'] ?? json['id'];

    if (id == null || id.toString().isEmpty) {
      throw FormatException('Card sem id');
    }

    return CardModel(
      id: id.toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      reviewStep: json['reviewStep'] ?? 0,
      nextReviewAt: json['nextReviewAt'] != null
          ? DateTime.tryParse(json['nextReviewAt'].toString())
          : null,
      lastReviewAt: json['lastReviewAt'] != null
          ? DateTime.tryParse(json['lastReviewAt'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reviewStep': reviewStep,
      'nextReviewAt': nextReviewAt?.toIso8601String(),
      'lastReviewAt': lastReviewAt?.toIso8601String(),
    };
  }
}
