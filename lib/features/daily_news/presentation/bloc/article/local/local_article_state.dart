part of 'local_article_bloc.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final bool isSaved;

  const LocalArticleState({this.articles, this.isSaved = false});

  @override
  List<Object?> get props => [articles, isSaved];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles, {super.isSaved})
      : super(articles: articles);
}