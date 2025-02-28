import 'package:intl/intl.dart';

class NewsResponse {
  final String status;
  final List<NewsItem> news;

  NewsResponse({required this.status, required this.news});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'],
      news: List<NewsItem>.from(
        json['news'].map((item) => NewsItem.fromJson(item)),
      ),
    );
  }
}

class NewsItem {
  final String id;
  final String title;
  final String description;
  final String url;
  final String author;
  final String? image;
  final String language;
  final List<String> category;
  final String published;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.author,
    this.image,
    required this.language,
    required this.category,
    required this.published,
  });

  get formatedDate {
    final date = DateTime.parse(published).toLocal();
    final dt = DateFormat('dd/MM/yyyy HH:mm').format(date);
    return dt;
  }

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      author: json['author'],
      image: json['image'],
      language: json['language'],
      category: List<String>.from(json['category']),
      published: json['published'],
    );
  }
}
