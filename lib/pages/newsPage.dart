import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:releae/features/news/newsModel.dart';
import 'package:releae/features/news/newsService.dart';
import 'package:releae/widgets/newsCard.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          'Notícias',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2F2F2F),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2F2F2F)),
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: newsService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Erro ao carregar notícias: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final news = snapshot.data ?? [];

          if (news.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma notícia encontrada.',
                style: TextStyle(color: Color(0xFF2F2F2F), fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final item = news[index];

              return NewsCard(news: item);
            },
          );
        },
      ),
    );
  }
}
