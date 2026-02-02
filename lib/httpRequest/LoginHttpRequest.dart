// import 'dart:convert';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>?> login({
  required String email,
  required String password,
}) async {
  final dio = Dio();
  final url = 'https://your-api.com/api/login'; // 替换为真实地址

  try {
    final response = await dio.post(
      url,
      data: {'email': email, 'password': password},
      options: Options(
        contentType: 'application/json; charset=utf-8',
        headers: {'Accept': 'application/json'},
      ),
    );

    // 成功：statusCode 2xx
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data as Map<String, dynamic>;
    } else {
      // 业务逻辑错误（如密码错误）
      // TDMessage.showMessage(
      //   context: context,
      //   visible: true,
      //   icon: true,
      //   content: '登录失败: ${response.statusMessage ?? '未知错误'}',
      //   theme: MessageTheme.error,
      //   duration: 3000,
      // );
      return null;
    }
  } catch (e) {
    // 网络错误、超时、解析失败等
    // String errorMsg = '网络错误';
    // if (e is DioException) {
    //   if (e.type == DioExceptionType.connectionTimeout) {
    //     errorMsg = '连接超时';
    //   } else if (e.type == DioExceptionType.receiveTimeout) {
    //     errorMsg = '接收超时';
    //   } else if (e.response != null) {
    //     errorMsg = '服务器错误: ${e.response?.statusCode}';
    //   }
    // }

    // TDMessage.showMessage(
    //   context: context,
    //   visible: true,
    //   icon: true,
    //   content: '登录失败: $errorMsg',
    //   theme: MessageTheme.error,
    //   duration: 3000,
    // );
    return null;
  }
}
