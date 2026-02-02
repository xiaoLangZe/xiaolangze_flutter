import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0),
              ],
              stops: [0.0, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset("assets/images/bg.png", fit: BoxFit.cover),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20, end: 20),
          child: Column(
            children: [
              SizedBox(height: 15),

              Align(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(child: Icon(Icons.qr_code_scanner, weight: 30)),
                    SizedBox(width: 20),
                    InkWell(child: Icon(Icons.settings_outlined, size: 25)),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Row(
                spacing: 10,
                children: [
                  TDAvatar(
                    size: TDAvatarSize.large,
                    type: TDAvatarType.normal,
                    shape: TDAvatarShape.square,
                    fit: BoxFit.cover,
                    defaultUrl: 'assets/images/bg.png',
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "小狼泽",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            TDTag('Lv1'),
                          ],
                        ),
                        Text("100/200", style: TextStyle(fontSize: 10)),
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              color: const Color(0xFFCCCCCC),
                              height: 3,
                            ),
                            Container(
                              width: 50,
                              color: const Color.fromARGB(255, 255, 73, 155),
                              height: 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: const Color.fromARGB(255, 225, 255, 170),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            TDIcons.edit_2,
                            size: 15,
                            color: const Color(0xFF74A500),
                          ),
                          Text(
                            "编辑资料",
                            style: TextStyle(
                              color: const Color(0xFF74A500),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        // color: const Color.fromARGB(255, 144, 144, 144),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.diamond, size: 30, color: Colors.black),
                            Text(
                              "我的会员",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        // color: const Color.fromARGB(255, 144, 144, 144),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.star, size: 30, color: Colors.black),
                            Text(
                              "我的收藏",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.history, size: 30, color: Colors.black),
                            Text(
                              "历史记录",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.download, size: 30, color: Colors.black),
                            Text(
                              "离线缓存",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              // TDNoticeBar(
              //   content: '本app所有内容均来自互联网分享站点所提供的公开引用资源,未提供资源上传、存储服务。',
              //   theme: TDNoticeBarTheme.warning,
              //   prefixIcon: TDIcons.error_circle_filled,
              //   marquee: true,
              //   // suffixIcon: TDIcons.close,
              // ),
              // SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1), // 黑色半透明阴影
                      blurRadius: 10, // 模糊半径（越大越模糊）
                      offset: Offset(0, 0), // 阴影偏移（x, y）
                      spreadRadius: 1, // 扩散半径（可选，默认0）
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "常用功能",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // color: const Color.fromARGB(255, 144, 144, 144),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.api,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "签到",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // color: const Color.fromARGB(255, 144, 144, 144),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.task,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "任务",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // color: const Color.fromARGB(255, 144, 144, 144),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.feedback,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "反馈",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              // child: Column(
                              //   children: [
                              //     Icon(
                              //       Icons.widgets,
                              //       size: 24,
                              //       color: Colors.black,
                              //     ),
                              //     Text(
                              //       "设置",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1), // 黑色半透明阴影
                      blurRadius: 10, // 模糊半径（越大越模糊）
                      offset: Offset(0, 0), // 阴影偏移（x, y）
                      spreadRadius: 1, // 扩散半径（可选，默认0）
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: Text(
                        "更多服务",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TDCell(
                      arrow: true,
                      title: '设置',
                      leftIcon: TDIcons.setting,
                      onClick: (cell) {},

                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
