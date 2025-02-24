import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_bloc_news/features/daily_news/presentation/widgets/article_tile_widget.dart';

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
            onPressed: () {},
            icon: Icon(Icons.watch_later_outlined),
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
            itemBuilder: (context, index) => ArticleTileWidget(
              article: state.articles![index],
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
      }),
    );
  }
}
