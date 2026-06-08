import 'package:dio/dio.dart';
import 'package:releae/core/apiClient.dart';
import 'package:releae/features/card/cardModel.dart';

class CardService {
  final Dio _dio = ApiClient.dio;

  Future<CardModel> createCard({
    required String title,
    required String description,
  }) async {
    final response = await _dio.post(
      '/card',
      data: {'title': title, 'description': description},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return _cardFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao criar card');
  }

  Future<List<CardModel>> findAll() async {
    final response = await _dio.get('/card');

    if (response.statusCode == 200) {
      return _cardsFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao buscar cards');
  }

  Future<List<CardModel>> findReviewCards() async {
    final response = await _dio.get('/card/review');

    if (response.statusCode == 200) {
      return _cardsFromResponse(response.data);
    }

    throw Exception(
      response.data['message'] ?? 'Erro ao buscar cards para revisao',
    );
  }

  Future<CardModel> findById(String id) async {
    final response = await _dio.get('/card/$id');

    if (response.statusCode == 200) {
      return _cardFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao buscar card');
  }

  Future<CardModel> reviewCard(String id) async {
    final response = await _dio.post('/card/$id/review', data: {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return _cardFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao revisar card');
  }

  Future<void> deleteCard(String id) async {
    final response = await _dio.delete('/card/$id', data: {});

    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    }

    throw Exception(response.data['message'] ?? 'Erro ao deletar card');
  }

  CardModel _cardFromResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      final cardData = data['card'];

      if (cardData is Map<String, dynamic>) {
        return _cardFromJson(cardData);
      }

      return _cardFromJson(data);
    }

    throw Exception('Resposta de card invalida');
  }

  List<CardModel> _cardsFromResponse(dynamic data) {
    if (data is List) {
      return data.map(_cardFromJson).toList();
    }

    if (data is Map<String, dynamic> && data['cards'] is List) {
      return (data['cards'] as List).map(_cardFromJson).toList();
    }

    throw Exception('Resposta de cards invalida');
  }

  CardModel _cardFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return CardModel.fromJson(json);
    }

    throw Exception('Resposta de card invalida');
  }
}
