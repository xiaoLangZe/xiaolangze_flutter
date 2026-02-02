import 'package:dio/dio.dart';

Future<Map<String, dynamic>?> SendFeedback({
  required String email,
  required String msg,
}) async {
  final dio = Dio();
  final url = 'https://your-api.com/api/sendFeedback';

  try {
    final response = await dio.post(
      url,
      data: {'email': email, 'msg': msg},
      options: Options(
        contentType: 'application/json; charset=utf-8',
        headers: {'Accept': 'application/json'},
      ),
    );

    // 成功：statusCode 2xx
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data as Map<String, dynamic>;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
