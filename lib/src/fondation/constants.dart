import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//HIVE BOX
const String newsBoxName = "news_box";
const String favoriteNewsBoxName = "favorites_news_box";
const String mediaBoxName = "media_box";
const String favoriteMediaBoxName = "favorites_media_box";

enum Flavor { development, production }

@immutable
class Constants {
  const Constants._({
    required this.endpoint,
    required this.apiKey,
  });

  factory Constants.of() {
    final flavor = EnumToString.fromString(
      Flavor.values,
      const String.fromEnvironment('FLAVOR'),
    );

    switch (flavor) {
      case Flavor.development:
        return Constants._dev();
      case Flavor.production:
      default:
        return Constants._prd();
    }
  }

  factory Constants._dev() {
    return const Constants._(
      endpoint: 'https://newsapi.org',
      apiKey: '262b9578f8b64d15b72c77de2ea0e9e6',
    );
  }

  factory Constants._prd() {
    return const Constants._(
      endpoint: 'https://newsapi.org',
      apiKey: '262b9578f8b64d15b72c77de2ea0e9e6',
    );
  }

  static final Constants instance = Constants.of();

  final String endpoint;
  final String apiKey;
}
