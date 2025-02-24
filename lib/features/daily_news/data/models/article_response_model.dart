import 'package:flutter_bloc_news/features/daily_news/data/models/article_model.dart';

class ArticleResponseModel {
  final List<ArticleModel> articles;

  ArticleResponseModel({required this.articles});

  factory ArticleResponseModel.fromJson(Map<String, dynamic> map) {
    return ArticleResponseModel(
      articles: (map["articles"] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList(),
    );
  }
}
