import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/util/onArticleTap.dart';
import '../../../domain/entities/article_entity.dart';
import '../../bloc/article/local/local_article_bloc.dart';
import '../../widgets/article_tile_widget.dart';

class SavedArticle extends HookWidget {
  const SavedArticle({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocalArticleBloc>().add(GetSavedArticles());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Articles",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (context, state) {
          if (state is LocalArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocalArticleDone) {
            return _buildArticleList(context, state.articles!);
          }
          return const Center(child: Text("No saved articles"));
        },
      ),
    );
  }

  Widget _buildArticleList(BuildContext context, List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(child: Text("There are no saved articles yet"));
    }
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(articles[index].id.toString()), // Ensure unique key
        onDismissed: (direction) {
          context.read<LocalArticleBloc>().add(RemoveArticle(articles[index]));
        },
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => onArticleTap(context, articles[index]),
          child: ArticleTileWidget(article: articles[index]),
        ),
      ),
      separatorBuilder: (_, __) => const Divider(),
    );
  }
}
