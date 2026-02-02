import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum LoginType {
  namePwdLogin, // 账号密码登录
  captchaLogin, // 验证码登录
  receiveCaptchaLogin, // 验证码接收页
  changepasswordReceiveCaptcha, // 修改密码接收验证码页
  changepasswordPage, // 修改密码页
  userManual, // 用户手册
}

String _emailStr = "";

// 校验email
bool isValidEmail(String email) {
  if (email.isEmpty) {
    return false;
  }
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9]+([._-][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*\.[a-zA-Z]{2,}$',
    caseSensitive: false, // 不区分大小写
  );
  return emailRegExp.hasMatch(email);
}

String maskEmail(String email) {
  final parts = email.split('@');
  final name = parts[0];
  final domain = parts[1];
  int keepLength = name.length ~/ 2;
  if (keepLength == 0) keepLength = 1;
  final visiblePart = name.substring(0, keepLength);
  final maskedPart = '*' * (name.length - keepLength);

  // 3. 拼接时加上 '@'
  return '$visiblePart$maskedPart@$domain';
}

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  LoginType _currentType = LoginType.namePwdLogin;
  DateTime? _lastPressedAt;

  void _switchTo(LoginType type) {
    setState(() {
      _currentType = type;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 禁用系统返回（由我们控制）
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          // 第一次点击，或超过2秒
          _lastPressedAt = now;
          Fluttertoast.showToast(
            msg: "再按一次取消登录",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Navigator.of(context).pop(); // 关闭当前页面
        }
      },
      child: Scaffold(
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
                          MediaQuery.of(context).size.height *
                          3 /
                          4, // 占据顶部1/4高度
                      child: Image.asset(
                        'assets/images/bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      top: 0,
                      bottom:
                          MediaQuery.of(context).size.height *
                          3 /
                          4, // 占据顶部1/4高度
                      child: Image.asset(
                        'assets/images/welcome.png',
                        fit: BoxFit.contain,
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
                        child: _buildCurrentPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentType) {
      case LoginType.captchaLogin:
        return CaptchaLogin(
          toReceiveCaptchaLogin: () => _switchTo(LoginType.receiveCaptchaLogin),
          toNamePwdLogin: () => _switchTo(LoginType.namePwdLogin),
        );
      case LoginType.namePwdLogin:
        return NamePwdLogin(
          toCaptchaLogin: () => _switchTo(LoginType.captchaLogin),
          forgetPasswd: () => _switchTo(LoginType.changepasswordReceiveCaptcha),
        );
      case LoginType.receiveCaptchaLogin:
        return ReceiveCaptchaLogin(
          toBack: () => _switchTo(LoginType.captchaLogin),
        );
      case LoginType.changepasswordReceiveCaptcha:
        return ChangepasswordReceiveCaptcha(
          toBack: () => _switchTo(LoginType.namePwdLogin),
          changePassword: () => _switchTo(LoginType.changepasswordPage),
        );
      case LoginType.changepasswordPage:
        return ChangepasswordPage(
          toBack: () => _switchTo(LoginType.namePwdLogin),
        );
      case LoginType.userManual:
        return NamePwdLogin(
          toCaptchaLogin: () => _switchTo(LoginType.captchaLogin),
          forgetPasswd: () => _switchTo(LoginType.changepasswordReceiveCaptcha),
        );
    }
  }
}

// 账号密码登录
class NamePwdLogin extends StatefulWidget {
  const NamePwdLogin({
    super.key,
    required this.toCaptchaLogin,
    required this.forgetPasswd,
  });
  final VoidCallback toCaptchaLogin;
  final VoidCallback forgetPasswd;

  @override
  State<NamePwdLogin> createState() => _NamePwdLoginState();
}

// 验证码登录
class CaptchaLogin extends StatefulWidget {
  const CaptchaLogin({
    super.key,
    required this.toNamePwdLogin,
    required this.toReceiveCaptchaLogin,
  });
  final VoidCallback toNamePwdLogin;
  final VoidCallback toReceiveCaptchaLogin;

  @override
  State<CaptchaLogin> createState() => _CaptchaLoginState();
}

// 接收验证码页面
class ReceiveCaptchaLogin extends StatefulWidget {
  const ReceiveCaptchaLogin({super.key, required this.toBack});
  final VoidCallback toBack;

  @override
  State<ReceiveCaptchaLogin> createState() => _ReceiveCaptchaLoginState();
}

// 修改密码(接收验证码页面)
class ChangepasswordReceiveCaptcha extends StatefulWidget {
  const ChangepasswordReceiveCaptcha({
    super.key,
    required this.toBack,
    required this.changePassword,
  });
  final VoidCallback toBack;
  final VoidCallback changePassword;

  @override
  State<ChangepasswordReceiveCaptcha> createState() =>
      _ChangepasswordReceiveCaptchaState();
}

// 修改密码(填写修改密码)
class ChangepasswordPage extends StatefulWidget {
  const ChangepasswordPage({super.key, required this.toBack});
  final VoidCallback toBack;
  @override
  State<ChangepasswordPage> createState() => _ChangepasswordPageState();
}

// 账号密码登录
class _NamePwdLoginState extends State<NamePwdLogin> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();
  bool _isObscure = true;
  bool _isAgreed = false;

  void login() {
    if (_controllerUser.text.isEmpty) {
    } else if (_controllerPwd.text.isEmpty) {}
  }

  @override
  void initState() {
    super.initState();
    _controllerUser.text = _emailStr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerUser,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: '请输入邮箱',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            ),
          ),
        ),

        SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerPwd,
            obscureText: _isObscure,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: '请输入密码',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Checkbox(
                value: _isAgreed,
                side: BorderSide(color: Colors.black, width: 2),
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '我已阅读并同意',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          child: Text(
                            '《用户手册》',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      TextSpan(text: '及'),
                      WidgetSpan(
                        child: GestureDetector(
                          child: Text(
                            '《隐私政策》',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 15),

        //登录按钮
        TextButton(
          onPressed: login,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlue),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
            ),
          ),

          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "登录",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 10,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: widget.toCaptchaLogin,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明
                foregroundColor: WidgetStateProperty.all(
                  Colors.blue,
                ), // 文字颜色（按需设置）
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域到文字大小
                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),
              child: Text("验证码登录/注册", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: widget.forgetPasswd,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明
                foregroundColor: WidgetStateProperty.all(
                  Colors.blue,
                ), // 文字颜色（按需设置）
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域到文字大小
                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),

              child: Text("忘记密码？", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}

// 验证码登录
class _CaptchaLoginState extends State<CaptchaLogin> {
  final TextEditingController _controllerUser = TextEditingController();
  bool _isAgreed = false;
  bool _canNext = false;

  void checkCanNext() {
    String currentText = _controllerUser.text;
    setState(() {
      _canNext = isValidEmail(currentText) && _isAgreed;
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerUser.text = _emailStr;
    // 检测邮箱
    _controllerUser.addListener(() {
      _emailStr = _controllerUser.text;
      checkCanNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "验证码登录/注册",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100], // 背景色（可自定义）
            borderRadius: BorderRadius.circular(12), // 圆角
          ),
          child: TextField(
            controller: _controllerUser,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: '请输入邮箱',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 4,
              ), // 关键：恢复合理的内边距
            ),
          ),
        ),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "未注册账号通过验证将自动注册",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Checkbox(
                value: _isAgreed,
                side: BorderSide(color: Colors.black, width: 2),
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                    checkCanNext();
                  });
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '我已阅读并同意',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          // onTap: _openUserManual,
                          child: Text(
                            '《用户手册》',
                            style: TextStyle(
                              color: Colors.blue,
                              // decoration:
                              //     TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(text: '及'),
                      WidgetSpan(
                        child: GestureDetector(
                          // onTap: _openUserManual,
                          child: Text(
                            '《隐私政策》',
                            style: TextStyle(
                              color: Colors.blue,
                              // decoration:
                              //     TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        TextButton(
          onPressed: () {
            if (_canNext) {
              _emailStr = _controllerUser.text;
              widget.toReceiveCaptchaLogin();
            }
          },

          style: ButtonStyle(
            // 移除水波纹
            overlayColor: WidgetStateProperty.resolveWith<Color?>((state) {
              return Colors.transparent; // 所有状态下都透明
            }),
            // 禁用按压时的颜色变化
            foregroundColor: WidgetStateProperty.resolveWith<Color>((state) {
              return Colors.blue; // 始终保持原始文字颜色
            }),
            backgroundColor: WidgetStateProperty.all<Color>(
              _canNext ? Colors.lightBlue : Colors.grey[100]!,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
            ),
          ),

          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "下一步",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: widget.toNamePwdLogin,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明
                foregroundColor: WidgetStateProperty.all(
                  Colors.blue,
                ), // 文字颜色（按需设置）
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域到文字大小
                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),
              child: Text("账号密码登录", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "feedback");
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明
                foregroundColor: WidgetStateProperty.all(
                  Colors.blue,
                ), // 文字颜色（按需设置）
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域到文字大小
                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),

              child: Text("遇到问题？", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}

// 接收验证码页面
class _ReceiveCaptchaLoginState extends State<ReceiveCaptchaLogin> {
  final TextEditingController _controllerCode = TextEditingController();
  int _countdown = 60; // 倒计时秒数
  bool _isCounting = false; // 是否正在倒计时
  late Timer _timer;

  void _startCountdown() {
    setState(() {
      _isCounting = true;
      _countdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 0) {
        _timer.cancel();
        setState(() {
          _isCounting = false;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void sendEmailCode() {
    _startCountdown();
  }

  @override
  void initState() {
    super.initState();
    sendEmailCode();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "请填写邮箱验证码",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text("验证码将发送至 ", style: TextStyle(color: Colors.black54)),
              Text(maskEmail(_emailStr), style: TextStyle(color: Colors.black)),
              Text(" ,请注意查收", style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100], // 背景色（可自定义）
            borderRadius: BorderRadius.circular(12), // 圆角
          ),
          child: TextField(
            controller: _controllerCode,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              // prefixIcon: Icon(Icons.email),
              hintText: '请输入验证码',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 15),

        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              widget.toBack();
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
              overlayColor: WidgetStateProperty.all(
                Colors.transparent,
              ), // 去掉水波纹/点击反馈
              backgroundColor: WidgetStateProperty.all(
                Colors.transparent,
              ), // 背景透明
              foregroundColor: WidgetStateProperty.all(
                Colors.blue,
              ), // 文字颜色（按需设置）
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 减小点击区域到文字大小
              alignment: Alignment.centerLeft, // 对齐方式（可选）
            ),
            child: Text("< 返回更换邮箱号码", style: TextStyle(color: Colors.black)),
          ),
        ),
        SizedBox(height: 10),

        TextButton(
          onPressed: _isCounting
              ? null
              : () {
                  sendEmailCode();
                },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              _isCounting ? Colors.grey[100]! : Colors.lightBlue,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                _isCounting ? '$_countdown 秒后重试' : '重新获取验证码',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 修改密码(接收验证码)
class _ChangepasswordReceiveCaptchaState
    extends State<ChangepasswordReceiveCaptcha> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerCode = TextEditingController();
  bool _canGetCode = false;

  int _countdown = 60; // 倒计时秒数
  bool _isCounting = false; // 是否正在倒计时
  late Timer _timer;

  void _startCountdown() {
    setState(() {
      _isCounting = true;
      _countdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 0) {
        _timer.cancel();
        setState(() {
          _isCounting = false;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void sendEmailCode() {
    if (_isCounting || !_canGetCode) {
      return;
    }
    _startCountdown();
  }

  @override
  void initState() {
    super.initState();
    _controllerUser.text = _emailStr;
    _controllerUser.addListener(() {
      _emailStr = _controllerUser.text;
      setState(() {
        _canGetCode = isValidEmail(_controllerUser.text);
      });
    });

    _controllerCode.addListener(() {
      if (_controllerCode.text.length == 6 &&
          _controllerCode.text == "123456") {
        widget.changePassword();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "找回密码",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerUser,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: '请输入邮箱',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            ),
          ),
        ),

        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerCode,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.code),
              hintText: '请输入验证码',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            ),
          ),
        ),
        SizedBox(height: 15),

        TextButton(
          onPressed: _isCounting ? null : sendEmailCode,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            backgroundColor: WidgetStateProperty.all<Color>(
              _isCounting || !_canGetCode
                  ? Colors.grey[100]!
                  : Colors.lightBlue,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                _isCounting ? '$_countdown 秒后重试' : '获取验证码',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: widget.toBack,
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明

                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),
              child: Text("< 返回", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}

// 修改密码(填写修改密码)
class _ChangepasswordPageState extends State<ChangepasswordPage> {
  final TextEditingController _controllerPwd1 = TextEditingController();
  final TextEditingController _controllerPwd2 = TextEditingController();

  bool _isObscurePwd1 = true;
  bool _isObscurePwd2 = true;

  bool _canChangePwd = false;

  @override
  void initState() {
    super.initState();

    _controllerPwd1.addListener(() {
      setState(() {
        _canChangePwd = _controllerPwd1.text == _controllerPwd2.text;
      });
    });

    _controllerPwd2.addListener(() {
      setState(() {
        _canChangePwd = _controllerPwd1.text == _controllerPwd2.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "修改密码",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerPwd1,
            obscureText: _isObscurePwd1,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: '请输入密码',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscurePwd1 = !_isObscurePwd1;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    _isObscurePwd1 ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _controllerPwd2,
            obscureText: _isObscurePwd2,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: '请输入密码',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscurePwd2 = !_isObscurePwd2;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    _isObscurePwd2 ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        TextButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero), // 去掉内边距
            overlayColor: WidgetStateProperty.all(Colors.transparent),

            backgroundColor: WidgetStateProperty.all<Color>(
              _canChangePwd ? Colors.lightBlue : Colors.grey[100]!,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 圆角
              ),
            ),
          ),
          onPressed: () {},
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "修改密码",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: widget.toBack,
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 去掉水波纹/点击反馈
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ), // 背景透明

                alignment: Alignment.centerLeft, // 对齐方式（可选）
              ),
              child: Text("< 返回", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ],
    );
  }
}
