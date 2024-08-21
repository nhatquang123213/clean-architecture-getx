import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'http.sevice.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  TokenInterceptor({
    this.recallForExpiredToken = false,
  });

  GetStorage get _store => GetStorage();
  final bool recallForExpiredToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final _accessToken = _store.read("ACCESS_TOKEN");
    options.headers.addAll({
      HttpHeaders.authorizationHeader: '${"TOKEN_TYPE"} $_accessToken',
    });

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException error, ErrorInterceptorHandler handler) async {
    final requestOptions = error.requestOptions;

    if (!recallForExpiredToken) {
      //401||403 config depend to BE
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        final hasNewToken = await refreshToken();
        if (hasNewToken) {
          //recall with new token
          await _recallAPI(requestOptions, handler);
        } else {
          logout();
          return handler.next(error);
        }
        return;
      }
    }

    return handler.next(error);
  }

  Future<void> _recallAPI(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    await HttpService.instance.getRecallDio().fetch(requestOptions).then(
      (r) => handler.resolve(r),
      onError: (error) async {
        if (error is DioException &&
            (error.response?.statusCode == 401 ||
                error.response?.statusCode == 403)) {
          final hasNewToken = await refreshToken();
          if (hasNewToken) {
            //recall with new token
            await _recallAPI(requestOptions, handler);
          } else {
            logout();
            return handler.next(error);
          }
          return;
        }
      },
    );
  }

  bool refreshToken() {
    //handle call refresh token -> set new token
    return true;
  }

  void logout() {
    //handle call refresh token failed -> logout
  }
}
