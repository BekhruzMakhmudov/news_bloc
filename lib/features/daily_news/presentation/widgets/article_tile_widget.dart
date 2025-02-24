import 'package:flutter/material.dart';
import 'package:flutter_bloc_news/core/util/formatDateTime.dart';
import 'package:flutter_bloc_news/features/daily_news/domain/entities/article_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleTileWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleTileWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildImage(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
    );
  }

  _buildImage() {
    return SizedBox(
      width: 100,
      height: 80,
      child: CachedNetworkImage(
        imageUrl: article?.urlToImage ?? '',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Icon(Icons.image_not_supported),
      ),
    );
  }

  _buildTitle() {
    return Text(
      article?.title ?? "No title",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }

  _buildSubtitle() {
    String dateTime = formatDateTime(article?.publishedAt);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          article?.description ?? "No description",
          maxLines: 2,
        ),
        Text(dateTime,style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
  }
}
