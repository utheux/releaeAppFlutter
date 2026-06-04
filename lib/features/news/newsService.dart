import 'package:dio/dio.dart';
import 'package:releae/core/apiClient.dart';
import 'package:releae/features/news/newsModel.dart';

class NewsService {
  final Dio _dio = ApiClient.dio;

  Future<List<NewsModel>> getNews() async {
    final response = await _dio.get('/redditPosts');

    if (response.statusCode == 200) {
      final List data = response.data;

      return data.map((json) => NewsModel.fromJson(json)).toList();
    }

    throw Exception(response.data['message'] ?? 'Erro ao buscar notícias');
  }
}
