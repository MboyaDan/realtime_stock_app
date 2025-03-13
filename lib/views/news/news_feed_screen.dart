import 'package:flutter/material.dart';
import 'package:realtime_stock_analytics/services/news_service.dart';
import 'package:realtime_stock_analytics/widgets/news_card.dart';
import 'package:realtime_stock_analytics/views/news/news_webview_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<Map<String, String>> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNewsData();
  }

  void fetchNewsData() async {
    try {
      List<Map<String, String>> news = await NewsService.fetchNews();
      setState(() {
        newsList = news;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching news data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return GestureDetector(
            onTap: () {
              if (news["url"] != null && news["url"]!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsWebViewScreen(url: news["url"]!),
                  ),
                );
              }
            },
            child: NewsCard(
              title: news["title"]!,
              source: news["source"]!,
              timeAgo: news["time"]!,
            ),
          );
        },
      ),
    );
  }
}
