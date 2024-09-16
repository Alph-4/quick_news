import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:quick_news/src/data/model/source.dart';

part 'news.g.dart';

@HiveType(typeId: 1) //typeId should be unique for each model
class NewModel {
  @HiveField(0)
  final Source source;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String urlToImage;
  @HiveField(6)
  final DateTime? publishedAt;
  @HiveField(7)
  final String content;

  NewModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    this.publishedAt,
    required this.content,
  });

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      source: Source.fromJson(json['source'] ?? <String, dynamic>{}),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt:
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(json['publishedAt']),
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source.toJson();
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}
