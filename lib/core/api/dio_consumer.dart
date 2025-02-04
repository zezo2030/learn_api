import 'package:dio/dio.dart';
import 'package:learn_api/core/api/api_consumer.dart';
import 'package:learn_api/core/api/api_interceptors.dart';
import 'package:learn_api/core/api/end_point.dart';
import 'package:learn_api/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final respons = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return respons.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      final respons = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return respons.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final respons = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return respons.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final respons = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return respons.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
