import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/onArticleTap.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';
import '../../widgets/article_tile_widget.dart';
import '../saved_article/saved_article.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily News",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedArticle()),
              );
            },
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
          if (state is RemoteArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RemoteArticlesDone) {
            return ListView.separated(
              itemCount: state.articles?.length ?? 0,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => onArticleTap(context, state.articles![index]),
                child: ArticleTileWidget(
                  article: state.articles![index],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Divider(height: 0),
              ),
            );
          } else {
            return const Center(
              child: Icon(Icons.refresh),
            );
          }
        },
      ),
    );
  }
}
