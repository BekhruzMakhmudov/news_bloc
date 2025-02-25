import 'package:flutter/material.dart';
import 'package:flutter_bloc_news/config/themes/app_themes.dart';
import 'package:flutter_bloc_news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_bloc_news/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
          create: (context) => sl()..add(const GetArticles()),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (context) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        home: DailyNews(),
      ),
    );
  }
}