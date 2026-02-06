import 'dart:convert';

import 'package:dio/dio.dart';
import "../globals.dart";

Future<Map<String, dynamic>?> login_sendCaptcha({
  required String userName,
  required String type,
}) async {
  var uri = API_USER_URL.replace(path: '/login_sendCaptcha');

  try {
    final resp = await dio.postUri(
      uri,
      data: {'userid': userName, 'type': type},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (resp.data is Map<String, dynamic>) {
      return resp.data;
    } else {
      return json.decode(resp.data);
    }
  } catch (e) {
    if (e is DioException) {
      final response = e.response;
      if (response != null) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String) {
          try {
            final jsonMap =
                json.decode(response.data as String) as Map<String, dynamic>;
            return jsonMap;
          } catch (_) {
            return {
              'code': response.statusCode,
              'msg': response.data.toString(),
            };
          }
        }
      }
      return {"code": 500, "msg": "无法连接到服务器"};
    }
    return {"code": 400, "msg": e.toString()};
  }
}

Future<Map<String, dynamic>?> login_checkCaptcha({
  required String userid,
  required String code,
}) async {
  var uri = API_USER_URL.replace(path: '/login_checkCaptcha');

  try {
    final resp = await dio.postUri(
      uri,
      data: {'userid': userid, "code": code},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (resp.data is Map<String, dynamic>) {
      return resp.data;
    } else {
      return json.decode(resp.data);
    }
  } catch (e) {
    if (e is DioException) {
      final response = e.response;
      if (response != null) {
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else if (response.data is String) {
          try {
            final jsonMap =
                json.decode(response.data as String) as Map<String, dynamic>;
            return jsonMap;
          } catch (_) {
            return {
              'code': response.statusCode,
              'msg': response.data.toString(),
            };
          }
        }
      }
    }
    return null;
  }
}
