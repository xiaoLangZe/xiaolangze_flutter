import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:xiaolangze/pages/homePage/homePage/homePage.dart';
import 'package:xiaolangze/pages/homePage/userPage/userPage.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});
  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBody: true,

      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: [HomePage(), HomePage(), HomePage(), Userpage()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: const CircleBorder(),
        onPressed: () {
          // Navigator.pushNamed(context, "login");
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Container(
                  // color: const Color.fromARGB(255, 144, 144, 144),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.home, size: 24, color: Colors.black),
                      Text("主页", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Container(
                  // color: const Color.fromARGB(255, 144, 144, 144),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.control_camera, size: 24, color: Colors.black),
                      Text("信息", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.task, size: 24, color: Colors.black),
                      Text("任务", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Container(
                  // color: const Color.fromARGB(255, 144, 144, 144),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.account_circle, size: 24, color: Colors.black),
                      Text("我的", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
