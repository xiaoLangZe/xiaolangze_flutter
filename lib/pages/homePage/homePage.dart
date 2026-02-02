import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      body: Center(
        child: Column(mainAxisAlignment: .center, children: [const Text('测试')]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, "login");
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                TDMessage.showMessage(
                  context: context,
                  visible: true,
                  icon: true,
                  content: '测试 错误',
                  theme: MessageTheme.error,
                  duration: 3000,
                );
              },
            ),
            IconButton(icon: Icon(Icons.control_camera), onPressed: () {}),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.markunread), onPressed: () {}),
            IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
