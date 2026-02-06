// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:xiaolangze/globals.dart';

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
                    InkWell(child: Icon(Icons.mail_outline, weight: 30)),
                    SizedBox(width: 20),
                    InkWell(child: Icon(Icons.settings_outlined, size: 25)),
                  ],
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                height: 60,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "login");
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 169, 200, 255),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "点击登录",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Row(
              //     spacing: 10,
              //     children: [
              //       TDAvatar(
              //         size: TDAvatarSize.large,
              //         type: TDAvatarType.normal,
              //         shape: TDAvatarShape.square,
              //         fit: BoxFit.cover,
              //         defaultUrl: 'assets/images/bg.png',
              //       ),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   BOX.get("userData")["userName"] == null
              //                       ? ""
              //                       : BOX.get("userData")!["userName"],
              //                   style: TextStyle(
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 SizedBox(width: 5),
              //                 TDTag('Lv1'),
              //               ],
              //             ),
              //             Text("100/200", style: TextStyle(fontSize: 10)),
              //             Stack(
              //               children: [
              //                 Container(
              //                   width: 100,
              //                   color: const Color(0xFFCCCCCC),
              //                   height: 3,
              //                 ),
              //                 Container(
              //                   width: 50,
              //                   color: const Color.fromARGB(
              //                     255,
              //                     255,
              //                     73,
              //                     155,
              //                   ),
              //                   height: 3,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       InkWell(
              //         child: Container(
              //           padding: EdgeInsets.all(7),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(
              //               Radius.circular(5),
              //             ),
              //             color: const Color.fromARGB(255, 225, 255, 170),
              //           ),
              //           child: Row(
              //             children: [
              //               Icon(
              //                 TDIcons.edit_2,
              //                 size: 15,
              //                 color: const Color(0xFF74A500),
              //               ),
              //               Text(
              //                 "编辑资料",
              //                 style: TextStyle(
              //                   color: const Color(0xFF74A500),
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              SizedBox(height: 20),

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
                    Padding(
                      padding: EdgeInsetsGeometry.only(
                        left: 20,
                        top: 10,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "累计收益:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                 "0.00"
                                    // : (BOX.get("userData")["allIncome"] / 100)!
                                    //       .toStringAsFixed(2),
                                // BOX.get("allIncome").toString(),
                                ,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          InkWell(child: Icon(Icons.visibility)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                                  Text("已提现金额", style: TextStyle()),
                                  Text(
                                    // (BOX.get("userData")["usedIncome"] / 100)
                                    //     .toStringAsFixed(2),
                                        "0.00"
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
                                  Text("未提现余额", style: TextStyle()),
                                  Text("0.00"),
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
                                  Text("积分余额", style: TextStyle()),
                                  Text("0"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 20),

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
                                  Icon(
                                    Icons.diamond,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "我的会员",
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
                                    Icons.star,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "我的收藏",
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
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "历史记录",
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
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.download,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "离线缓存",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
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
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "兑换码",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
                    SizedBox(height: 10),

                    InkWell(
                      onTap: () {
                        print("个性装扮");
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("我的钱包", style: TextStyle(fontSize: 16)),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),

                    // Align(
                    //   alignment: AlignmentGeometry.centerRight,
                    //   child: Container(
                    //     margin: EdgeInsets.only(left: 15, right: 15),
                    //     width: double.infinity,
                    //     height: 1,
                    //     color: const Color(0x22000000),
                    //   ),
                    // ),

                    // InkWell(
                    //   onTap: () {
                    //     print("个性装扮");
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: 15,
                    //       right: 15,
                    //       top: 10,
                    //       bottom: 10,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("个性装扮", style: TextStyle(fontSize: 16)),
                    //         Icon(Icons.arrow_forward_ios, size: 16),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Align(
                    //   alignment: AlignmentGeometry.centerRight,
                    //   child: Container(
                    //     margin: EdgeInsets.only(left: 15, right: 15),
                    //     width: double.infinity,
                    //     height: 1,
                    //     color: const Color(0x22000000),
                    //   ),
                    // ),

                    // InkWell(
                    //   onTap: () {
                    //     print("个性装扮");
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: 15,
                    //       right: 15,
                    //       top: 10,
                    //       bottom: 10,
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text("我的勋章(实验)", style: TextStyle(fontSize: 16)),
                    //         Icon(Icons.arrow_forward_ios, size: 16),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
