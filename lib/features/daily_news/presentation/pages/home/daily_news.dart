import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_news/core/constants/constants.dart';

import '../../../../../core/util/onArticleTap.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';
import '../../bloc/category/category_bloc.dart';
import '../../widgets/article_tile_widget.dart';
import '../saved_article/saved_article.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(),
    );
  }
}

_buildAppBar(BuildContext context) {
  return AppBar(
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
  );
}

_buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: Colors.blue,
        ),
        ListTile(
          tileColor: Colors.blue,
          title: Text(
            "Category",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: NewsCategory.values.length,
            itemBuilder: (context, index) => _buildDrawerItem(
              context,
              NewsCategory.values[index].toString().split('.').last,
            ),
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 0),
          ),
        ),
      ],
    ),
  );
}


_buildDrawerItem(BuildContext context, String category) {
  return BlocBuilder<CategoryBloc, CategoryState>(
    builder: (context, state) {
      bool isSelected = state.selectedCategory == category;
      return ListTile(
        title: Text(
          category,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        selected:isSelected,
        selectedColor: Colors.blue,
        onTap: () {
          if (!isSelected) {
            context.read<CategoryBloc>().add(ChangeCategory(category));
            context.read<RemoteArticleBloc>().add(GetArticles(category));
            Navigator.pop(context);
          }
        },
      );
    },
  );
}

_buildBody() {
  return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
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
  );
}
