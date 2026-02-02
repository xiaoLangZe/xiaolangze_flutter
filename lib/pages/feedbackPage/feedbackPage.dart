import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});
  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerMsg = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                  child: Container(
                    color: const Color(0xFFFFFFFF),
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(
                        left: 30,
                        right: 30,
                        top: 30,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "问题反馈",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _controllerEmail,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLength: 1000,
                            decoration: InputDecoration(
                              labelText: '联系方式',
                              hintText: '请输入邮箱/QQ/微信',
                              border: OutlineInputBorder(),
                              counterText: '',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _controllerMsg,
                            maxLines: null,
                            minLines: 4,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLength: 100,
                            decoration: InputDecoration(
                              labelText: '*意见反馈',
                              hintText: '请描述您遇到的问题或建议(最少5字)',
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              if (_controllerMsg.text.isEmpty) {
                                TDMessage.showMessage(
                                  context: context,
                                  visible: true,
                                  icon: true,
                                  content: '意见反馈不能为空',
                                  theme: MessageTheme.error,
                                  duration: 3000,
                                );
                                return;
                              }
                              if (_controllerMsg.text.length < 5) {
                                TDMessage.showMessage(
                                  context: context,
                                  visible: true,
                                  icon: true,
                                  content: '请输入最少五个字',
                                  theme: MessageTheme.error,
                                  duration: 3000,
                                );
                                return;
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.lightBlue,
                              ),
                              shape:
                                  WidgetStateProperty.all<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8.0,
                                      ), // 圆角
                                    ),
                                  ),
                            ),

                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "提交反馈",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
