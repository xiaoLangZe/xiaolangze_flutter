import 'package:flutter/material.dart';
import 'package:xiaolangze/pages/loginPage/loginPage.dart';
import 'package:xiaolangze/pages/homePage/homePage.dart';

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
            page = const MyHomePage();
            break;
          case 'login': // 登录页
            page = const Loginpage();
            break;
          case "describe": // 描述页
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
