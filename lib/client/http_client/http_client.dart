library http_client;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookies/cookies.dart';

class Client {
  final String baseUrl;

  final http.Client _client = new http.Client();

  Client({this.baseUrl: ''});

  Future<http.Response> get(String path,
      {Map<String, String> headers, Map<String, String> queryParams}) async {
    Uri uri = new Uri.http(baseUrl, path, queryParams);
    final http.Response resp = await _client.get(uri, headers: headers);
    //TODO handle cookies
    return resp;
  }

  Future<http.Response> post(String path,
      {Map<String, String> headers,
      Map<String, String> queryParams,
      String body,
      Encoding encoding}) async {
    Uri uri = new Uri.http(baseUrl, path, queryParams);
    final resp = await _client.post(uri,
        headers: headers, body: body, encoding: encoding);
    //TODO handle cookies
    return resp;
  }
}
