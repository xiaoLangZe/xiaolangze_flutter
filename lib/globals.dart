import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:device_info_plus/device_info_plus.dart';

final dio = Dio();

// Uri GLOBALS_SERVER_Host = Uri.parse("https://zys.xiaolangze.qzz.io/");
Uri GLOBALS_SERVER_Host = Uri.parse("http://10.29.0.111:8787");
// 用户服务器地址
Uri API_USER_URL = GLOBALS_SERVER_Host;
Uri API_SEND_EMAIL = GLOBALS_SERVER_Host;

// 数据库
// var HIVE_DAtA_BASE = Hive;
