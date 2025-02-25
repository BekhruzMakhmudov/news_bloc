import 'package:floor/floor.dart';
import 'package:flutter_bloc_news/features/daily_news/data/models/article_model.dart';

@dao
abstract class ArticleDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(ArticleModel article);

  @Query('DELETE FROM article WHERE url = :url')
  Future<void> deleteArticleByUrl(String url);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();

  @Query('SELECT * FROM article WHERE url = :url LIMIT 1')
  Future<ArticleModel?> getArticleByUrl(String url);
}