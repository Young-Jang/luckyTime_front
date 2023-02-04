import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:lucky_time_app/rest/rest_service.dart';

import 'dto/get_lucky_number.dart';

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
  final TextEditingController _textController = new TextEditingController();
  Future<GetLuckyNumber> luckynum = getLuckyNumber("1");
  String result = "1";
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
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: getLuckyNumber,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => getLuckyNumber(_textController.text).then((value) => result = value.luckyNumber)),
            ),
            Container(
                child: Center(
                    child: FutureBuilder<GetLuckyNumber>(
                        future: luckynum,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              else {
                                String? l = snapshot.data?.luckyNumber;
                                return Text(l.toString());
                              }
                          }
                        }))),
            new Text(result),
          ],
        ),
      ),
    );
  }
}
