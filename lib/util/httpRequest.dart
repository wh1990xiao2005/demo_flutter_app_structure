import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:io';

class HttpRequest {
  HttpRequest(this.url);

  final String url;

  Future<String> httpRequest() async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String responseContent = await response.transform(utf8.decoder).join();
      httpClient.close();
      return responseContent;
    } catch (e) {
      debugPrint("请求失败：$e");
      return "";
    } finally {
      debugPrint("结束Http操作");
    }
  }
}
