import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/areas/home/models/home_model.dart';

import 'package:dio/dio.dart';

class HomeRepository {
  HomeRepository(this.dio);

  final Dio dio;

  static const String baseUrl = 'https://flutter.webspark.dev';
  static const String endPoint = '/flutter/api';

  Future<ResponsePathData?> getPath(String url) async {
    try {
      final response = await dio.get(url);

      return ResponsePathData(
        error: response.data['error'],
        message: response.data['message'],
        data: (response.data['data'] as List<dynamic>)
            .map((item) => PathData.fromJson(item))
            .toList(),
      );
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
