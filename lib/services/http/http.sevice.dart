import 'package:code_base/services/http/token_interceptor.dart';
import 'package:dio/dio.dart';

class HttpService {
  HttpService._();

  static final HttpService instance = HttpService._();

  late Dio _dio;
  late Dio _anonymousDio;

  void init() {
    _dio = _newDio();
    _anonymousDio = _newDio();
  }

  Dio _newDio() {
    final baseOptions = BaseOptions(
      baseUrl: "apiUrl",
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );
    return Dio(baseOptions);
  }

  Dio getDio({bool isAnonymous = false}) {
    if (isAnonymous) {
      _anonymousDio.interceptors.clear();
      return _anonymousDio;
    }
    _dio.interceptors
      ..clear()
      ..add(
        TokenInterceptor(),
      );
    return _dio;
  }

  Dio getRecallDio() {
    final dio = _newDio();
    dio.interceptors
      ..clear()
      ..add(
        TokenInterceptor(
          recallForExpiredToken: true,
        ),
      );
    return dio;
  }

  FormData mapToFormData(Map<String, dynamic> map) {
    final formData = FormData.fromMap(map);
    final FormData newData = FormData();

    ///
    formData.fields.forEach((element) {
      newData.fields.add(MapEntry(element.key, element.value));
    });

    ///
    formData.files.forEach((element) {
      if (element.key.contains('[') || element.key.contains(']')) {
        final newKey =
            element.key.replaceAllMapped(RegExp('([+[a-zA-Z]+])'), (m) {
          return '${m[0]}'.replaceAll('[', '.').replaceAll(']', '');
        });
        final newValue = element.value;
        final newEntry = MapEntry(newKey, newValue);
        newData.files.add(newEntry);
      } else {
        newData.files.add(element);
      }
    });

    return newData;
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Response response = await getDio().get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<Response> refreshToken(String url,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    final Response response = await _anonymousDio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );

    return response;
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
    Function(int count, int total)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    if (formData != null) {
      data = mapToFormData(formData);
    }
    final Response response = await getDio().post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
      cancelToken: cancelToken,
    );
    return response;
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? formData,
    bool isAnonymous = false,
  }) async {
    if (formData != null) {
      data = mapToFormData(formData);
    }
    final Response response = await getDio(isAnonymous: isAnonymous).put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final Response response = await getDio().delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<Response> request(String url,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      Map<String, dynamic>? formData,
      Function(int count, int total)? onSendProgress}) async {
    if (formData != null) {
      data = mapToFormData(formData);
    }
    final Response response = await getDio().request(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );
    return response;
  }

  Future<Response> fetch(RequestOptions options) async {
    final Response response = await getDio().fetch(
      options,
    );
    return response;
  }
}
