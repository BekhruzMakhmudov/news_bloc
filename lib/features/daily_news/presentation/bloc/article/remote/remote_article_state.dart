part of 'remote_article_bloc.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const RemoteArticleState({this.articles, this.error});
  @override
  List<Object?> get props => [articles!,error!];
}

final class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

final class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> articles):super(articles:articles);
}

final class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException error):super(error:error);
}
