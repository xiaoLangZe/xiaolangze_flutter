import 'package:flutter/material.dart';
import 'package:xiaolangze/pages/feedbackPage/feedbackPage.dart';
import 'package:xiaolangze/pages/handbook/handbook.dart';
import 'package:xiaolangze/pages/loginPage/loginPage.dart';
import 'package:xiaolangze/pages/homePage/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '追影兽',
      initialRoute: "home",
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

      onGenerateRoute: (settings) {
        Widget? page;
        switch (settings.name) {
          case 'home': // 主页
            page = const MyMainPage();
            break;
          case 'login': // 登录页
            page = const Loginpage();
            break;
          case "handbook": // 用户手册 及 隐私政策
            final String? title = settings.arguments as String?;
            page = Handbook(title: title);
            break;
          case "feedback": // 反馈
            page = const FeedBack();
            break;
        }

        if (page == null) return null;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page!,
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
