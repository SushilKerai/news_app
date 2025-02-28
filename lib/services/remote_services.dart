import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/data/models/categoties.dart';
import 'package:news_app/data/models/language.dart';
import 'package:news_app/data/models/news_response.dart';

class NewsService {
  Future<NewsResponse> fetchNews({required int Page}) async {
    try {
      final url = Uri.parse(
          "https://api.currentsapi.services/v1/latest-news?apiKey=JC28ggolOTJE8r_qsrpMTGyVG1-S-RkE2S_LQNbESHgNh9Yb&page_number=$Page&page_size=10");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      if (e is SocketException) throw Exception('No Internet');
      throw Exception('Something went wrong');
    }
  }
}

class CategoryService {
  Future<CategoryModel> fetchCategory() async {
    try {
      final url = Uri.parse(
          'https://api.currentsapi.services/v1/available/categories?apiKey=JC28ggolOTJE8r_qsrpMTGyVG1-S-RkE2S_LQNbESHgNh9Yb&page_size=10');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return CategoryModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      if (e is SocketException) throw Exception('No Internet');
      throw Exception('Something went wrong');
    }
  }
}

class NewsSearch {
  Future<NewsResponse> fetchNews(
      {String? category,
      String? region,
      String? language,
      int page = 1}) async {
    try {
      Uri url = Uri.parse('https://api.currentsapi.services/v1/search');

      url = url.replace(queryParameters: {
        'apiKey': 'JC28ggolOTJE8r_qsrpMTGyVG1-S-RkE2S_LQNbESHgNh9Yb',
        if (category != null) 'category': category,
        'page_number': page.toString(),
        'page_size': '10',
        if (region != null) 'country': region,
        if (language != null) 'language': language,
      });
      print(url.toString());

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      if (e is SocketException) throw Exception('No Internet');
      throw Exception('Something went wrong');
    }
  }
}

class RegionService {
  Future<List<MapEntry<String, dynamic>>> fetchRegions() async {
    try {
      final url =
          'https://api.currentsapi.services/v1/available/regions?apiKey=JC28ggolOTJE8r_qsrpMTGyVG1-S-RkE2S_LQNbESHgNh9Yb&page_size=10';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['regions'] is Map) {
          return (data['regions'] as Map<String, dynamic>).entries.toList();
        } else {
          throw Exception('Invalid regions format');
        }
      } else {
        throw Exception('Failed to fetch regions: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) throw Exception('No Internet');
      throw Exception('Something went wrong');
    }
  }
}

class LanguageService {
  final String _baseUrl =
      'https://api.currentsapi.services/v1/available/languages';
  final String _apiKey =
      'JC28ggolOTJE8r_qsrpMTGyVG1-S-RkE2S_LQNbESHgNh9Yb&page_size=10';

  Future<List<MapEntry<String, dynamic>>> fetchLanguages() async {
    try {
      final Uri uri = Uri.parse('$_baseUrl?apiKey=$_apiKey');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['languages'] is Map) {
          return (data['languages'] as Map<String, dynamic>).entries.toList();
        } else {
          throw Exception('Invalid languages format');
        }
      } else {
        throw Exception('Failed to fetch languages: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) throw Exception('No Internet');
      throw Exception('Something went wrong');
    }
  }
}
