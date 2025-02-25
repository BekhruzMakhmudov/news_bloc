import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_news/core/util/formatDateTime.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_bloc_news/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_bloc_news/injection_container.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ArticleDetail extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetail({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LocalArticleBloc>()
        ..add(
          CheckIfArticleSaved(article!),
        ),
      child: BlocConsumer<LocalArticleBloc, LocalArticleState>(
          listener: (context, state) {
            if (state is LocalArticleDone) {
              context.read<LocalArticleBloc>().add(CheckIfArticleSaved(article!));
            }
          },
          builder: (context, state) {
            bool isSaved = false;
            if (state is LocalArticleDone) {
              isSaved = state.isSaved;
            }
            return Scaffold(
              appBar: _buildAppBar(context, isSaved),
              body: _buildBody(context),
            );
          }),
    );
  }

  _buildAppBar(BuildContext context, bool isSaved) {
    return AppBar(
      leading: BackButton(),
      title: Text(
        "Article Detail",
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (isSaved) {
              context.read<LocalArticleBloc>().add(RemoveArticle(article!));
            } else {
              context.read<LocalArticleBloc>().add(SaveArticle(article!));
            }
            context.read<LocalArticleBloc>().add(CheckIfArticleSaved(article!));
          },
          icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_outline),
        ),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildTitle(context),
            _buildImage(),
            _buildDescription(),
          ],
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(article!.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall),
        Text(formatDateTime(article!.publishedAt!)),
      ],
    );
  }

  _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: Image.network(
          article!.urlToImage!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildDescription() {
    String content = article!.content ?? "No content";
    if (article!.content != null) {
      content = content.replaceAll(RegExp(r'\s*\[\+\d+\s+chars\]$'), '');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(article!.description ?? "No description"),
        SizedBox(height: 8),
        Text(content),
      ],
    );
  }
}
