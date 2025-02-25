import 'package:flutter/material.dart';

import '../../features/daily_news/domain/entities/article_entity.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';

void onArticleTap(BuildContext context, ArticleEntity? article) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ArticleDetail(
        article: article,
      ),
    ),
  );
}