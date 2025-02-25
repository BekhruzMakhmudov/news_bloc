import 'package:flutter_bloc_news/core/resources/data_state.dart';
import 'package:flutter_bloc_news/core/usecases/usecase.dart';
import '../entities/article_entity.dart';
import '../repository/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, String> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({required String params}) {
    return _articleRepository.getNewsArticles(category: params);
  }
}
