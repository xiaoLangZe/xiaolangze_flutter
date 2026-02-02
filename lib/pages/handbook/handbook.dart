import 'package:flutter/material.dart';

class Handbook extends StatefulWidget {
  const Handbook({super.key, required this.title});
  final String? title;

  @override
  State<Handbook> createState() => _HandbookState();
}

class _HandbookState extends State<Handbook> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity, // 或指定具体高度
          child: Stack(
            children: [
              // 图片部分
              Stack(
                children: [
                  Positioned.fill(
                    top: 0,
                    bottom:
                        MediaQuery.of(context).size.height * 3 / 4, // 占据顶部1/4高度
                    child: Image.asset(
                      'assets/images/bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    top: 0,
                    bottom:
                        MediaQuery.of(context).size.height * 3 / 4, // 占据顶部1/4高度
                    child: Center(
                      child: Text(
                        " 遇到问题了？",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height:
                    MediaQuery.of(context).size.height * 3.1 / 4, // 占据底部3/4高度
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
