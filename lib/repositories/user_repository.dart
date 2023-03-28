import 'package:code_test/models/responses/user_response.dart';
import 'package:code_test/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepository {
  static const _baseUrl = "https://reqres.in/api/users";
  final Dio _dio = Dio();

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get(_baseUrl);

      final users = UserResponse.fromJson(response.data);
      return users.data;
    } catch (error) {
      throw Exception('Failed to load users: $error');
    }
  }
}
