// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future postData(List<int> body) async {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"indexes":body}),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      print('This is the postdata response $data');
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}