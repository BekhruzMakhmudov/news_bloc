import 'package:flutter_bloc_news/core/usecases/usecase.dart';

import '../entities/article_entity.dart';
import '../repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;
  RemoveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) async {
    if (params == null) return;
    await _articleRepository.removeArticle(params);
  }
}
