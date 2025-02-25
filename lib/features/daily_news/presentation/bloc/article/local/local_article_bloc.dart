import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/usecases/get_saved_article.dart';

part 'local_article_event.dart';

part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
    on<CheckIfArticleSaved>(onCheckIfArticleSaved);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
    RemoveArticle event,
    Emitter<LocalArticleState> emit,
  ) async {
    await _removeArticleUseCase(params: event.article);
    final articles = await _getSavedArticlesUseCase();
    final isSaved = articles.any((saved) => saved.url == event.article!.url);
    emit(LocalArticleDone(articles, isSaved: isSaved));
  }

  void onSaveArticle(SaveArticle event, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: event.article);
    final articles = await _getSavedArticlesUseCase();
    final isSaved = articles.any((saved) => saved.url == event.article!.url);
    emit(LocalArticleDone(articles, isSaved: isSaved));
  }

  void onCheckIfArticleSaved(
    CheckIfArticleSaved event,
    Emitter<LocalArticleState> emit,
  ) async {
    final articles = await _getSavedArticlesUseCase();
    final isSaved = articles.any((saved) => saved.url == event.article!.url);
    emit(LocalArticleDone(articles, isSaved: isSaved));
  }
}
