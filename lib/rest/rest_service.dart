import 'package:flutter_study/dto/get_lucky_number.dart';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';

Future<GetLuckyNumber> getLuckyNumber(String cnt) async {
  final response = await http.get(Uri.parse('http://localhost:8080/lotto/get-lucky-number?count='+cnt));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var logger = Logger();
    logger.i(response.body);
    var responseJson = json.decode(response.body);
    logger.d(responseJson);
    return GetLuckyNumber.fromJson(responseJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load server data');
  }
}