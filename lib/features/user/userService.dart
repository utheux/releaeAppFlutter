import 'package:dio/dio.dart';
import 'package:releae/core/apiClient.dart';
import 'package:releae/features/user/userModel.dart';

class UserService {
  final Dio _dio = ApiClient.dio;

  Future<UserModel> createUser({
    required String name,
    required String surName,
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/users',
      data: {
        'name': name,
        'surName': surName,
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      return _userFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao criar usuário');
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return _userFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Erro ao fazer login');
  }

  Future<UserModel> me() async {
    final response = await _dio.get('/users/me');

    if (response.statusCode == 200) {
      return _userFromResponse(response.data);
    }

    throw Exception(response.data['message'] ?? 'Usuário não autenticado');
  }

  Future<void> logout() async {
    final response = await _dio.post('/users/logout');

    if (response.statusCode == 204) {
      await ApiClient.clearCookies();
      return;
    }

    throw Exception('Erro ao fazer logout');
  }

  UserModel _userFromResponse(dynamic data) {
    if (data is Map<String, dynamic>) {
      final userData = data['user'];

      if (userData is Map<String, dynamic>) {
        return UserModel.fromJson(userData);
      }

      return UserModel.fromJson(data);
    }

    throw Exception('Resposta de usuário inválida');
  }
}
