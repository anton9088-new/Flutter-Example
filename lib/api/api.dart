import 'dart:convert';
import 'package:example/api/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}

class GiphyApi {
  static const baseUrl = 'https://api.giphy.com/v1';
  final String apiKey;
  final http.Client httpClient;

  GiphyApi({
    @required this.apiKey,
    @required this.httpClient
  });

  Future<GiphyPage> loadTrendingImages(int offset, int limit) async {
    final trendingUrl = '$baseUrl/gifs/trending?api_key=$apiKey&offset=$offset&limit=$limit';
    final response = await httpClient.get(trendingUrl);

    if (response.statusCode != 200) {
      throw ApiException('invalid http status code: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    final page = GiphyPage.fromJson(json);

    if (page.meta.status != 200) {
      throw ApiException('invalid json status code: ${page.meta.status}');
    }

    return page;
  }
}