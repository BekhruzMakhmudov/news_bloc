import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_news/core/resources/data_state.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/entities/article_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/usecases/get_article.dart';

part 'remote_article_event.dart';

part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event,
      Emitter<RemoteArticleState> emit,
      ) async {
    emit(const RemoteArticlesLoading());
    final dataState = await _getArticleUseCase(params: event.category);
    print("Fetched articles: ${dataState.data}");
    if (dataState is DataSuccess) {
      final articles = dataState.data ?? [];

      if (articles.isNotEmpty) {
        emit(RemoteArticlesDone(articles));
      } else {
        print("Article list is empty");
        throw DioException;
      }
    } else if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
