part of 'remote_article_bloc.dart';

abstract class RemoteArticleEvent extends Equatable {
  const RemoteArticleEvent();

  @override
  List<Object?> get props => [];
}

class GetArticles extends RemoteArticleEvent {
  final String category;
  const GetArticles(this.category);

  @override
  List<Object?> get props => [category];
}
