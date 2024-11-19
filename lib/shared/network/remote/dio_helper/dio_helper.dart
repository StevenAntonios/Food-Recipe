import 'package:dio/dio.dart';

abstract class DioHelper{
  static Dio? _dio;

  static Future<void> initializeDio()async{
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://www.themealdb.com/api/json/v1/1/",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        validateStatus: (status) {
          return (status! < 506);
        },
      ),
    );
  }

  //GET
  static Future<Response> getRequest({
  required String endPoint,
  Map<String,dynamic>? queryParameters,
})async{
    return await _dio!.get(endPoint,queryParameters: queryParameters);
  }

  //POST
  static Future<Response> postRequest({
  required String endPoint,
  required Map<String,dynamic> data,
})async{
    return await _dio!.post(endPoint,data: data);
}
}