import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/controllers/news_controller.dart';
import 'package:realtime_stock_analytics/widgets/news_card.dart';
import 'package:realtime_stock_analytics/views/news/news_webview_screen.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Market News")),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (newsProvider.newsList.isEmpty) {
            return const Center(child: Text("No news available."));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await newsProvider.fetchNews(); // Ensures fresh data
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: newsProvider.newsList.length,
              itemBuilder: (context, index) {
                final news = newsProvider.newsList[index];
                return NewsCard(
                  news: news,
                  onTap: () {
                    if (news.url.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsWebViewScreen(news: news),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
