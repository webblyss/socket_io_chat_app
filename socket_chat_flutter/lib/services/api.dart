import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'http://localhost:3001';
  }

  Future<Response> postData(dynamic data) async {
    try {
      return await _dio.post('/test/', data: data);
    } catch (e) {
      // Handle exceptions
      rethrow;
    }
  }
}
