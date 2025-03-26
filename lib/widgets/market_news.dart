import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_analytics/controllers/news_controller.dart';
import 'package:realtime_stock_analytics/models/news_model.dart';
import 'package:realtime_stock_analytics/views/news/news_webview_screen.dart';

class MarketNewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        if (newsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (newsProvider.newsList.isEmpty) {
          return const Center(child: Text("No market news available."));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Market News",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the full News Feed Screen
                    Navigator.pushNamed(context, '/news');
                  },
                  child: const Text("View All"),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsProvider.newsList.length,
                itemBuilder: (context, index) {
                  final NewsModel news = newsProvider.newsList[index];

                  return GestureDetector(
                    onTap: () {
                      if (news.url.isNotEmpty) {
                        // Open News in WebView
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsWebViewScreen(news: news),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: 220,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              news.imageUrl.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  news.imageUrl,
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : const SizedBox(height: 0),
                              const SizedBox(height: 8),
                              Text(
                                news.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                news.source,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
