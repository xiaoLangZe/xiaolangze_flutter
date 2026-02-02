import 'package:flutter/material.dart';

enum LoginType {
  namePwdLogin, // 账号密码登录
  captchaLogin, // 验证码登录
  receiveCaptchaLogin, // 验证码接收页
  changepasswordReceiveCaptcha, // 修改密码接收验证码页
  changepasswordPage, // 修改密码页
  userManual, // 用户手册
}

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

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  LoginType _currentType = LoginType.captchaLogin;
  

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
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentType) {
      case LoginType.captchaLogin:
        return CaptchaLogin(
          toNamePwdLogin: () => _switchTo(LoginType.namePwdLogin),
        );
      case LoginType.namePwdLogin:
        return NamePwdLogin(
          voidCallback: () => _switchTo(LoginType.captchaLogin),
        );
      case LoginType.receiveCaptchaLogin:
      case LoginType.changepasswordReceiveCaptcha:
      case LoginType.changepasswordPage:
      case LoginType.userManual:
        return NamePwdLogin(
          voidCallback: () => _switchTo(LoginType.captchaLogin),
        );
    }
  }
}

// 账号密码登录
class NamePwdLogin extends StatefulWidget {
  const NamePwdLogin({super.key, required this.voidCallback});
  final VoidCallback voidCallback;

  @override
  State<NamePwdLogin> createState() => _NamePwdLoginState();
}

// 验证码登录
class CaptchaLogin extends StatefulWidget {
  const CaptchaLogin({super.key, required this.toNamePwdLogin});
  final VoidCallback toNamePwdLogin;

  @override
  State<CaptchaLogin> createState() => _CaptchaLoginState();
}

// 接收验证码页面
class ReceiveCaptchaLogin extends StatefulWidget {
  const ReceiveCaptchaLogin({super.key, required this.voidCallback});
  final VoidCallback voidCallback;

  @override
  State<ReceiveCaptchaLogin> createState() => _ReceiveCaptchaLoginState();
}

// 修改密码(接收验证码页面)
class ChangepasswordReceiveCaptcha extends StatefulWidget {
  const ChangepasswordReceiveCaptcha({super.key, required this.voidCallback});
  final VoidCallback voidCallback;
  @override
  State<ChangepasswordReceiveCaptcha> createState() =>
      _ChangepasswordReceiveCaptchaState();
}

// 修改密码(填写修改密码)
class ChangepasswordPage extends StatefulWidget {
  const ChangepasswordPage({super.key, required this.voidCallback});
  final VoidCallback voidCallback;
  @override
  State<ChangepasswordPage> createState() => _ChangepasswordPageState();
}

// 账号密码登录
class _NamePwdLoginState extends State<NamePwdLogin> {
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();
  bool _isObscure = true;
  bool _isAgreed = false;

  @override
  void initState() {
    super.initState();
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

        TextButton(
          onPressed: () {},
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
              onPressed: widget.voidCallback,
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
              child: Text("验证码登录", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "验证码登录",
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
        SizedBox(height: 10),
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
          onPressed: () {},
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
              onPressed: () {},
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerUser = TextEditingController();
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
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text("验证码将发送至", style: TextStyle(color: Colors.black54)),
              Text("《》", style: TextStyle(color: Colors.black)),
              Text(",请注意查收", style: TextStyle(color: Colors.black54)),
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
            controller: controllerUser,
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
            onPressed: () {},
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
            child: Text("< 返回更换手机号", style: TextStyle(color: Colors.black)),
          ),
        ),
        SizedBox(height: 30),
        TextButton(
          onPressed: () {},
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
                "下一步",
                style: TextStyle(color: Colors.black, fontSize: 20),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// 修改密码(填写修改密码)
class _ChangepasswordPageState extends State<ChangepasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
