import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() {
  KakaoContext.clientId = '0e705aebca54eb152b63a4ba3b38253a';
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KakaoLogin',
      home: KakaoLoginPage(),
    );
  }
}

class KakaoLoginPage extends StatefulWidget {
  @override
  _KakaoLoginPageState createState() => _KakaoLoginPageState();
}

class _KakaoLoginPageState extends State<KakaoLoginPage> {
  Future<void> _loginButtonPressed() async {
    String authCode = await AuthCodeClient.instance.request();
    print(authCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                onPressed: _loginButtonPressed,
                color: Colors.yellow,
                child: Text(
                  '카카오 로그인',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}