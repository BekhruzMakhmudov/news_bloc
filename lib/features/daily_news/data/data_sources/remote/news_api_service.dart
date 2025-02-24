import 'package:flutter_bloc_news/core/constants/constants.dart';
import 'package:flutter_bloc_news/features/daily_news/data/models/article_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<ArticleResponseModel>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("category") String? category,
  });
}
