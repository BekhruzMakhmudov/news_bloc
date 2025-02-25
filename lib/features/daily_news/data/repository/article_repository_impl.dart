import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_news/core/constants/constants.dart';
import 'package:flutter_bloc_news/core/resources/data_state.dart';
import 'package:flutter_bloc_news/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_bloc_news/features/daily_news/data/models/article_model.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/repository/article_repository.dart';
import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        category: category,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.articles);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles()async {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.deleteArticleByUrl(article.url!);
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    final existingArticle = await _appDatabase.articleDAO.getArticleByUrl(article.url!);
    if (existingArticle == null) {
      await _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
    }
  }
}
